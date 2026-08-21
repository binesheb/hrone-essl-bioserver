using System.Diagnostics;
using System.Net;
using System.Text;
using System.Text.Json;
using Microsoft.Data.SqlClient;

namespace HROneSyncService;

public static class DashboardServer
{
    private const string ServiceName = "HROneSyncService";
    private static HttpListener? _listener;
    private static string _connectionString = string.Empty;
    private static readonly object SyncRoot = new();
    private static Action? _stopApplication;
    public static readonly SemaphoreSlim CheckpointGate = new(1, 1);
    public static bool ResyncPending { get; private set; }

    public static void Start(string connectionString, int port = 8009, Action? stopApplication = null)
    {
        lock (SyncRoot)
        {
            if (_listener?.IsListening == true) return;
            _connectionString = connectionString;
            _stopApplication = stopApplication;
            _listener = new HttpListener();
            _listener.Prefixes.Add($"http://+:{port}/");
            _listener.Start();
            _ = Task.Run(ListenLoop);
        }
    }

    private static async Task ListenLoop()
    {
        while (_listener?.IsListening == true)
        {
            try { var context = await _listener.GetContextAsync(); _ = Task.Run(() => HandleRequest(context)); }
            catch (HttpListenerException) { break; }
            catch (ObjectDisposedException) { break; }
        }
    }

    private static async Task HandleRequest(HttpListenerContext context)
    {
        try
        {
            var path = context.Request.Url?.AbsolutePath?.TrimEnd('/').ToLowerInvariant() ?? "";
            if (path is "") { await WriteHtml(context, BuildDashboardHtml(), 200); return; }
            if (path == "/api/data" && context.Request.HttpMethod == "GET") { await WriteJson(context, await GetDashboardData(), 200); return; }
            if (path == "/api/punch-state" && context.Request.HttpMethod == "GET") { await WriteJson(context, await GetPunchState(), 200); return; }
            if (path == "/api/health" && context.Request.HttpMethod == "GET") { await WriteJson(context, await GetHealth(), 200); return; }
            if (path == "/api/checkpoint" && context.Request.HttpMethod == "POST") { await SetCheckpoint(context); return; }
            if (path == "/api/resync" && context.Request.HttpMethod == "POST") { await Resync(context); return; }
            if (path == "/api/date-sync" && context.Request.HttpMethod == "POST") { await DateSync(context); return; }
            if (path == "/api/service/control" && context.Request.HttpMethod == "POST") { await ServiceControl(context); return; }
            await WriteJson(context, new { error = "Not found", path }, 404);
        }
        catch (Exception ex) { await WriteJson(context, new { error = ex.Message, type = ex.GetType().Name }, 500); }
        finally { context.Response.Close(); }
    }

    private static async Task<object> GetHealth()
    {
        try { await using var c = await OpenConnection(); return new { ok = true, database = "Connected", service = GetServiceStatus(), checkedAt = DateTime.Now }; }
        catch (Exception ex) { return new { ok = false, database = "Failed", service = GetServiceStatus(), error = ex.Message, type = ex.GetType().Name, checkedAt = DateTime.Now }; }
    }

    private static async Task<object> GetPunchState()
    {
        try { await using var c = await OpenConnection(); var latest = await ScalarLong(c, "SELECT ISNULL(MAX(DeviceLogId),0) FROM eBioServerNew.dbo.DeviceLogs"); return new { ok = true, latestLogId = latest, checkedAt = DateTime.Now }; }
        catch (Exception ex) { return new { ok = false, latestLogId = 0L, error = ex.Message, type = ex.GetType().Name, checkedAt = DateTime.Now }; }
    }

    private static async Task SetCheckpoint(HttpListenerContext context)
    {
        var request = await ReadJson<CheckpointRequest>(context);
        if (request is null || request.LastProcessedDeviceLogId < 0) { await WriteJson(context, new { error = "A valid LastProcessedDeviceLogId is required." }, 400); return; }
        await CheckpointGate.WaitAsync();
        try
        {
            await using var c = await OpenConnection();
            await using var tx = (SqlTransaction)await c.BeginTransactionAsync();
            try
            {
                var old = await ScalarLong(c, "SELECT ISNULL(MAX(LastProcessedDeviceLogId),0) FROM dbo.HROneSyncState", transaction: tx);
                await using var cmd = new SqlCommand(@"IF EXISTS (SELECT 1 FROM dbo.HROneSyncState) UPDATE dbo.HROneSyncState SET LastProcessedDeviceLogId=@Value ELSE INSERT INTO dbo.HROneSyncState (LastProcessedDeviceLogId) VALUES (@Value);", c, tx);
                cmd.Parameters.AddWithValue("@Value", request.LastProcessedDeviceLogId);
                await cmd.ExecuteNonQueryAsync(); await tx.CommitAsync();
                ResyncPending = false;
                await WriteJson(context, new { success = true, oldValue = old, newValue = request.LastProcessedDeviceLogId, message = "Checkpoint updated. You can now start a safe resync from this point." }, 200);
            }
            catch { await tx.RollbackAsync(); throw; }
        }
        finally { CheckpointGate.Release(); }
    }

    private static async Task Resync(HttpListenerContext context)
    {
        var request = await ReadJson<CheckpointRequest>(context);
        if (request is null || request.LastProcessedDeviceLogId < 0) { await WriteJson(context, new { error = "A valid LastProcessedDeviceLogId is required." }, 400); return; }
        if (_stopApplication is null) { await WriteJson(context, new { error = "Service lifecycle control is not configured." }, 503); return; }
        await CheckpointGate.WaitAsync();
        try
        {
            await using var c = await OpenConnection();
            await using var tx = (SqlTransaction)await c.BeginTransactionAsync();
            try
            {
                await using var cmd = new SqlCommand(@"IF EXISTS (SELECT 1 FROM dbo.HROneSyncState) UPDATE dbo.HROneSyncState SET LastProcessedDeviceLogId=@Value ELSE INSERT INTO dbo.HROneSyncState (LastProcessedDeviceLogId) VALUES (@Value);", c, tx);
                cmd.Parameters.AddWithValue("@Value", request.LastProcessedDeviceLogId);
                await cmd.ExecuteNonQueryAsync(); await tx.CommitAsync(); ResyncPending = true;
            }
            catch { await tx.RollbackAsync(); throw; }
        }
        finally { CheckpointGate.Release(); }
        await WriteJson(context, new { success = true, action = "resync", checkpoint = request.LastProcessedDeviceLogId, message = "Safe resync requested. Current processing will stop gracefully and the Windows service will restart from this checkpoint." }, 200);
        _ = Task.Run(async () => { await Task.Delay(750); ScheduleServiceStart(); _stopApplication(); });
    }

    private static async Task DateSync(HttpListenerContext context)
    {
        var request = await ReadJson<DateSyncRequest>(context);
        if (request is null || !DateOnly.TryParse(request.Date, out var date)) { await WriteJson(context, new { error = "A valid date is required (YYYY-MM-DD)." }, 400); return; }
        await using var c = await OpenConnection();
        var nextDate = date.AddDays(1);
        const string sql = @"SELECT TOP 1 DeviceLogId, EmployeeCode, LogDate, DeviceId FROM eBioServerNew.dbo.DeviceLogs WHERE LogDate >= @Start AND LogDate < @End ORDER BY LogDate ASC, DeviceLogId ASC";
        await using var find = new SqlCommand(sql, c) { CommandTimeout = 10 };
        find.Parameters.AddWithValue("@Start", date.ToDateTime(TimeOnly.MinValue));
        find.Parameters.AddWithValue("@End", nextDate.ToDateTime(TimeOnly.MinValue));
        await using var rd = await find.ExecuteReaderAsync();
        if (!await rd.ReadAsync()) { await WriteJson(context, new { success = false, found = false, message = $"No punch was found on {date:yyyy-MM-dd}." }, 404); return; }
        var firstId = rd.GetInt64(0); var employee = rd.IsDBNull(1) ? "-" : rd.GetString(1); var logDate = rd.GetDateTime(2); var device = rd.IsDBNull(3) ? "-" : rd.GetValue(3).ToString(); await rd.CloseAsync();
        var checkpoint = await FindPreviousLogId(c, firstId);
        await WriteJson(context, new { success = true, found = true, date = date.ToString("yyyy-MM-dd"), firstPunch = new { deviceLogId = firstId, employeeCode = employee, logDate, deviceId = device }, recommendedCheckpoint = checkpoint, message = "First punch found. The recommended checkpoint is the latest DeviceLogId before this punch." }, 200);
    }

    private static async Task<long> FindPreviousLogId(SqlConnection c, long firstId)
    {
        await using var cmd = new SqlCommand("SELECT ISNULL(MAX(DeviceLogId),0) FROM eBioServerNew.dbo.DeviceLogs WHERE DeviceLogId < @Id", c) { CommandTimeout = 10 }; cmd.Parameters.AddWithValue("@Id", firstId); return Convert.ToInt64(await cmd.ExecuteScalarAsync() ?? 0L);
    }

    private static async Task ServiceControl(HttpListenerContext context)
    {
        var request = await ReadJson<ServiceControlRequest>(context); var action = request?.Action?.Trim().ToLowerInvariant();
        if (action is not ("stop" or "restart" or "update")) { await WriteJson(context, new { error = "Action must be stop, restart, or update." }, 400); return; }
        var config = ConfigureServiceToCurrentExecutable(); if (!config.Success) { await WriteJson(context, new { success = false, action, message = config.Message }, 500); return; }
        if (action == "update") { await WriteJson(context, new { success = true, action, message = "Windows service path updated.", path = CurrentExecutablePath() }, 200); return; }
        if (_stopApplication is null) { await WriteJson(context, new { error = "Service lifecycle control is not configured." }, 503); return; }
        if (action == "stop") { await WriteJson(context, new { success = true, action, message = "Stop requested." }, 200); _ = Task.Run(async () => { await Task.Delay(750); _stopApplication(); }); return; }
        await WriteJson(context, new { success = true, action, message = "Restart requested." }, 200); _ = Task.Run(async () => { await Task.Delay(750); ScheduleServiceStart(); _stopApplication(); });
    }

    private static (bool Success, string Message) ConfigureServiceToCurrentExecutable()
    {
        var exe = CurrentExecutablePath(); if (!File.Exists(exe)) return (false, $"Current service executable was not found: {exe}"); var r = RunSc("config", ServiceName, "binPath=", $"\"{exe}\"", "start=", "auto"); return r.ExitCode == 0 ? (true, r.Output) : (false, $"Service configuration failed ({r.ExitCode}): {r.Output}");
    }
    private static string CurrentExecutablePath() => Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, "HROneSyncService.exe"));
    private static void ScheduleServiceStart() { try { var p = new ProcessStartInfo { FileName = "cmd.exe", UseShellExecute = false, CreateNoWindow = true, WindowStyle = ProcessWindowStyle.Hidden }; p.ArgumentList.Add("/c"); p.ArgumentList.Add("timeout /t 3 /nobreak >nul & sc.exe start HROneSyncService >nul"); Process.Start(p); } catch { } }
    private static string GetServiceStatus() { var r = RunSc("query", ServiceName); if (r.ExitCode != 0) return "Not installed"; if (r.Output.Contains("RUNNING", StringComparison.OrdinalIgnoreCase)) return "Running"; if (r.Output.Contains("STOPPED", StringComparison.OrdinalIgnoreCase)) return "Stopped"; return "Transitioning"; }
    private static (int ExitCode, string Output) RunSc(params string[] arguments) { try { var p = new ProcessStartInfo { FileName = "sc.exe", UseShellExecute = false, RedirectStandardOutput = true, RedirectStandardError = true, CreateNoWindow = true }; foreach (var a in arguments) p.ArgumentList.Add(a); using var process = Process.Start(p); if (process is null) return (-1, "Unable to start sc.exe."); var output = process.StandardOutput.ReadToEnd(); var error = process.StandardError.ReadToEnd(); process.WaitForExit(10000); return (process.ExitCode, string.IsNullOrWhiteSpace(error) ? output.Trim() : error.Trim()); } catch (Exception ex) { return (-1, ex.Message); } }

    private sealed class CheckpointRequest { public long LastProcessedDeviceLogId { get; set; } }
    private sealed class DateSyncRequest { public string? Date { get; set; } }
    private sealed class ServiceControlRequest { public string? Action { get; set; } }
    private static async Task<T?> ReadJson<T>(HttpListenerContext context) { using var body = new StreamReader(context.Request.InputStream, context.Request.ContentEncoding); var json = await body.ReadToEndAsync(); return JsonSerializer.Deserialize<T>(json, new JsonSerializerOptions { PropertyNameCaseInsensitive = true }); }
    private static async Task<SqlConnection> OpenConnection() { var b = new SqlConnectionStringBuilder(_connectionString) { ConnectTimeout = 5 }; var c = new SqlConnection(b.ConnectionString); await c.OpenAsync(); return c; }
    private static async Task WriteJson(HttpListenerContext context, object value, int statusCode) { var bytes = Encoding.UTF8.GetBytes(JsonSerializer.Serialize(value, new JsonSerializerOptions { PropertyNamingPolicy = JsonNamingPolicy.CamelCase })); context.Response.StatusCode = statusCode; context.Response.ContentType = "application/json; charset=utf-8"; context.Response.Headers["Cache-Control"] = "no-store, no-cache, must-revalidate"; await context.Response.OutputStream.WriteAsync(bytes); }
    private static async Task WriteHtml(HttpListenerContext context, string html, int statusCode) { var bytes = Encoding.UTF8.GetBytes(html); context.Response.StatusCode = statusCode; context.Response.ContentType = "text/html; charset=utf-8"; context.Response.Headers["Cache-Control"] = "no-store, no-cache, must-revalidate"; await context.Response.OutputStream.WriteAsync(bytes); }

    private static async Task<object> GetDashboardData()
    {
        try { await using var c = await OpenConnection(); var last = await ScalarLong(c, "SELECT ISNULL(MAX(LastProcessedDeviceLogId),0) FROM dbo.HROneSyncState"); var latest = await ScalarLong(c, "SELECT ISNULL(MAX(DeviceLogId),0) FROM eBioServerNew.dbo.DeviceLogs"); var today = await ScalarLong(c, "SELECT COUNT_BIG(*) FROM eBioServerNew.dbo.DeviceLogs WHERE CAST(LogDate AS date)=CAST(GETDATE() AS date)"); var uploaded = await ScalarLong(c, "SELECT COUNT_BIG(*) FROM eBioServerNew.dbo.DeviceLogs WHERE DeviceLogId<=@LastId AND CAST(LogDate AS date)=CAST(GETDATE() AS date)", new SqlParameter("@LastId", last)); return new { ok = true, generatedAt = DateTime.Now, health = new { database = true, service = GetServiceStatus() }, summary = new { totalToday = today, uploadedToday = uploaded, pending = Math.Max(0, latest - last), successRate = today == 0 ? 100 : Math.Round(uploaded * 100.0 / today, 1), lastProcessedId = last, latestLogId = latest }, recent = await GetRecent(c, last) }; }
        catch (Exception ex) { return new { ok = false, generatedAt = DateTime.Now, error = ex.Message, type = ex.GetType().Name, summary = new { totalToday = 0L, uploadedToday = 0L, pending = 0L, successRate = 0d, lastProcessedId = 0L, latestLogId = 0L }, recent = Array.Empty<object>() }; }
    }
    private static async Task<long> ScalarLong(SqlConnection c, string sql, params SqlParameter[] p) => await ScalarLong(c, sql, null, p);
    private static async Task<long> ScalarLong(SqlConnection c, string sql, SqlTransaction? transaction, params SqlParameter[] p) { await using var cmd = new SqlCommand(sql, c, transaction) { CommandTimeout = 10 }; cmd.Parameters.AddRange(p); var v = await cmd.ExecuteScalarAsync(); return v is null or DBNull ? 0 : Convert.ToInt64(v); }
    private static async Task<List<object>> GetRecent(SqlConnection c, long last)
    {
        var r = new List<object>();
        const string sql = @"SELECT TOP 25 d.DeviceLogId, d.EmployeeCode, e.EmployeeName, d.LogDate, d.DeviceId
FROM eBioServerNew.dbo.DeviceLogs d
LEFT JOIN eBioServerNew.dbo.Employees e ON e.EmployeeCode = d.EmployeeCode
ORDER BY d.DeviceLogId DESC";
        await using var cmd = new SqlCommand(sql, c) { CommandTimeout = 10 };
        await using var rd = await cmd.ExecuteReaderAsync();
        while (await rd.ReadAsync())
        {
            var code = rd.IsDBNull(1) ? "-" : rd.GetString(1);
            var name = rd.IsDBNull(2) ? "-" : rd.GetString(2);
            r.Add(new { id = rd.GetInt64(0), employee = name, employeeCode = code, time = rd.GetDateTime(3).ToString("yyyy-MM-dd HH:mm:ss"), machine = rd.GetValue(4).ToString(), status = rd.GetInt64(0) <= last ? "Uploaded" : "Pending" });
        }
        return r;
    }

    private static string BuildDashboardHtml() => """
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>HROne Sync Dashboard</title>
<style>
:root{--bg:#080d19;--p:#111827;--p2:#0d1423;--b:#263247;--t:#f4f7ff;--m:#8f9db7;--g:#38d987;--a:#ffc35a;--r:#ff667e;--bl:#78aaff;--shadow:0 10px 28px rgba(0,0,0,.18)}*{box-sizing:border-box}body{margin:0;font-family:Segoe UI,Arial,sans-serif;background:radial-gradient(circle at top,#101a2d 0,#080d19 46%);color:var(--t);font-size:14px}header{position:sticky;top:0;z-index:10;padding:13px 22px;border-bottom:1px solid var(--b);background:rgba(8,13,25,.96);backdrop-filter:blur(12px);display:flex;justify-content:space-between;align-items:center;gap:18px}.brand{display:flex;align-items:center;gap:11px;min-width:0}.brandmark{width:34px;height:34px;border-radius:9px;background:linear-gradient(135deg,var(--bl),#4c73ca);display:grid;place-items:center;font-weight:800;color:#07101f}.brandtitle{font-weight:800;font-size:15px}.wrap{max-width:1500px;margin:auto;padding:16px 20px 26px}.panel{background:linear-gradient(180deg,var(--p),var(--p2));border:1px solid var(--b);border-radius:11px;padding:14px;margin-bottom:11px;box-shadow:var(--shadow)}.cards{display:grid;grid-template-columns:repeat(4,minmax(0,1fr));gap:10px;margin-bottom:11px}.card{min-height:88px;margin:0}.label{font-size:10px;color:var(--m);text-transform:uppercase;letter-spacing:.07em}.value{font-size:25px;font-weight:800;margin-top:5px}.small{font-size:11px;color:var(--m);line-height:1.4}.toolbar{display:flex;align-items:flex-start;justify-content:flex-end;gap:14px}.refreshbox{text-align:right}.refreshbox button{min-width:118px}.statusbar{display:flex;align-items:center;gap:7px;color:var(--m);font-size:11px;padding-top:5px}.dot{width:8px;height:8px;border-radius:50%;display:inline-block;background:var(--a)}.dot.ok{background:var(--g)}.dot.bad{background:var(--r)}button{border:0;border-radius:7px;padding:8px 11px;font-weight:750;cursor:pointer;background:var(--bl);color:#07101f;white-space:nowrap}button:hover{filter:brightness(1.07)}button.danger{background:var(--r);color:#fff}button.green{background:var(--g);color:#07101f}button.yellow{background:var(--a);color:#07101f}.secondary{background:#253149;color:var(--t);border:1px solid #35435d}.errorbox{background:#351620;border:1px solid var(--r);padding:10px;border-radius:8px;margin-bottom:11px}.sectionhead{display:flex;align-items:center;justify-content:space-between;gap:10px;margin-bottom:10px}.sectionhead h3{margin:0;font-size:13px}.topgrid{display:grid;grid-template-columns:1.35fr .9fr;gap:11px}.syncgrid{display:grid;grid-template-columns:1fr 1fr;gap:10px}.syncbox{background:rgba(255,255,255,.018);border:1px solid var(--b);border-radius:9px;padding:12px}.checkpointrow{display:flex;gap:28px;align-items:end;flex-wrap:wrap}.checkpointstat .value{font-size:24px}.row{display:flex;gap:7px;flex-wrap:wrap;align-items:end}.field{flex:1;min-width:145px}label{display:block;font-size:10px;color:var(--m)}input{background:#090f1d;color:var(--t);border:1px solid var(--b);border-radius:7px;padding:8px;width:100%;margin-top:4px;outline:none}input:focus{border-color:var(--bl)}.actionline{display:flex;gap:7px;align-items:center;flex-wrap:wrap;margin-top:9px}.servicebar{display:flex;align-items:center;justify-content:space-between;gap:12px;flex-wrap:wrap}.service-actions{display:flex;gap:7px;flex-wrap:wrap}.service-state{display:flex;align-items:center;gap:7px;font-weight:700}.tablewrap{overflow:auto;border:1px solid var(--b);border-radius:8px}table{width:100%;border-collapse:collapse;min-width:760px}th,td{padding:8px 9px;border-bottom:1px solid var(--b);text-align:left;font-size:11px}th{color:var(--m);font-size:9px;text-transform:uppercase;letter-spacing:.06em;background:#0d1524}tbody tr:last-child td{border-bottom:0}tbody tr:hover{background:rgba(120,170,255,.04)}.success{color:var(--g)}.warn{color:var(--a)}.badge{display:inline-flex;padding:3px 7px;border-radius:99px;font-size:9px;font-weight:700;background:#253149}.badge.success{background:rgba(56,217,135,.12)}.badge.warn{background:rgba(255,195,90,.12)}@media(max-width:980px){.cards{grid-template-columns:repeat(2,1fr)}.topgrid,.syncgrid{grid-template-columns:1fr}}@media(max-width:620px){header{padding:11px 13px}.wrap{padding:11px}.cards{gap:8px}.panel{padding:11px}.brandtitle{font-size:13px}.toolbar{width:100%;justify-content:space-between}.refreshbox{text-align:left}.statusbar{padding-top:8px}.servicebar{align-items:flex-start}}
</style></head><body>
<header><div class="brand"><div class="brandmark">H</div><div><div class="brandtitle">HROne ESSL Biometric Sync</div><div class="small">Live synchronization control center</div></div></div><div class="toolbar"><div class="refreshbox"><button id="refresh">Refresh Now</button><div class="small" id="lastRefresh">Last refresh: —</div></div><div id="health" class="statusbar"><span class="dot"></span><span>Checking...</span></div></div></header>
<main class="wrap"><div id="error"></div>
<div class="cards"><div class="panel card"><div class="label">Today</div><div id="today" class="value">—</div><div class="small">Punch records</div></div><div class="panel card"><div class="label">Uploaded Today</div><div id="uploaded" class="value">—</div><div class="small">Reached checkpoint</div></div><div class="panel card"><div class="label">Pending</div><div id="pending" class="value">—</div><div class="small">Awaiting HROne sync</div></div><div class="panel card"><div class="label">Success</div><div id="rate" class="value">—</div><div class="small">Today's checkpoint ratio</div></div></div>
<div class="topgrid"><section class="panel"><div class="sectionhead"><h3>Synchronization</h3><span class="small">Current processing position</span></div><div class="checkpointrow"><div class="checkpointstat"><div class="label">Last Processed</div><div id="checkpoint" class="value">—</div></div><div class="small">→</div><div class="checkpointstat"><div class="label">Latest DeviceLogId</div><div id="latest" class="value">—</div></div><div class="checkpointstat"><div class="label">Pending</div><div id="pendingInline" class="value">—</div></div></div></section><section class="panel"><div class="sectionhead"><h3>Service Control</h3><span id="serviceState" class="service-state"><span class="dot"></span>Checking</span></div><div class="servicebar"><span class="small">Windows service lifecycle</span><div class="service-actions"><button id="stop" class="danger">Stop</button><button id="restart" class="yellow">Restart</button><button id="update" class="green">Update</button></div></div><div id="serviceMsg" class="msg"></div></section></div>
<section class="panel"><div class="sectionhead"><h3>Sync Control</h3><span class="small">Change checkpoint only when required</span></div><div class="syncgrid"><div class="syncbox"><div class="label">Sync from Date</div><div class="small">Find the first punch on a day and calculate a safe checkpoint immediately before it.</div><div class="row" style="margin-top:7px"><div class="field"><label for="syncDate">Date</label><input id="syncDate" type="date"></div><button id="findDate" class="green">Find First Punch</button></div><div id="dateResult" class="msg"></div><div id="dateAction" class="actionline"></div></div><div class="syncbox"><div class="label">Manual Checkpoint</div><div class="small">Set a specific DeviceLogId. Setting it does not start resync until you explicitly choose it.</div><div class="row" style="margin-top:7px"><div class="field"><label for="checkpointInput">DeviceLogId</label><input id="checkpointInput" type="number" min="0" placeholder="DeviceLogId"></div><button id="setCheckpoint" class="yellow">Set Checkpoint</button></div><div id="checkpointMsg" class="msg"></div><div id="resyncAction" class="actionline"></div></div></div></section>
<section class="panel"><div class="sectionhead"><h3>Recent Punches</h3><span class="small">Latest 25 records</span></div><div class="tablewrap"><table><thead><tr><th>DeviceLogId</th><th>Employee Code</th><th>Employee Name</th><th>Time</th><th>Device</th><th>Status</th></tr></thead><tbody id="recent"></tbody></table></div></section></main>
<script>
let busy=false,lastKnownLogId=null;const $=id=>document.getElementById(id);
async function getJson(url,options={}){const r=await fetch(url+'?t='+Date.now(),{cache:'no-store',...options});const j=await r.json();if(!r.ok&&j.error)throw new Error(j.error);return j}
function showResyncButton(v){$('resyncAction').innerHTML='<button id="resync" class="danger">Start Safe Resync from '+v+'</button><div class="small">The current worker operation is allowed to finish or cancel safely. The checkpoint is protected from being overwritten, then the Windows service restarts.</div>';$('resync').onclick=async()=>{if(!confirm('Safely restart syncing from LastProcessedDeviceLogId '+v+'? Records with DeviceLogId greater than '+v+' will be eligible for processing again.'))return;try{$('checkpointMsg').textContent='Preparing safe resync...';const j=await getJson('/api/resync',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({lastProcessedDeviceLogId:v})});$('checkpointMsg').innerHTML='<span class="success">'+esc(j.message)+'</span>';$('resyncAction').innerHTML='<span class="success">Resync requested. The service is restarting from '+v+'.</span>'}catch(e){$('checkpointMsg').innerHTML='<span class="warn">'+esc(e.message)+'</span>'}}}
function render(d,reason='Manual'){if(!d.ok){$('error').innerHTML='<div class="errorbox">'+esc(d.type||'Error')+': '+esc(d.error||'Dashboard error')+'</div>';return}$('error').innerHTML='';const s=d.summary;$('today').textContent=s.totalToday.toLocaleString();$('uploaded').textContent=s.uploadedToday.toLocaleString();$('pending').textContent=s.pending.toLocaleString();$('pendingInline').textContent=s.pending.toLocaleString();$('rate').textContent=s.successRate+'%';$('checkpoint').textContent=s.lastProcessedId.toLocaleString();$('latest').textContent=s.latestLogId.toLocaleString();$('checkpointInput').value=s.lastProcessedId;$('lastRefresh').textContent='Last refresh: '+new Date(d.generatedAt).toLocaleString()+' • '+reason;lastKnownLogId=s.latestLogId;$('recent').innerHTML=d.recent.map(x=>'<tr><td>'+x.id+'</td><td>'+esc(x.employeeCode)+'</td><td><strong>'+esc(x.employee)+'</strong></td><td>'+x.time+'</td><td>'+esc(x.machine)+'</td><td>'+x.status+'</td></tr>').join('')}
async function refresh(reason='Manual'){if(busy)return;busy=true;try{const d=await getJson('/api/data');render(d,reason)}catch(e){$('error').innerHTML='<div class="errorbox">'+esc(e.message)+'</div>'}finally{busy=false}}
async function poll(){try{const s=await getJson('/api/punch-state');if(lastKnownLogId!==null&&s.latestLogId>lastKnownLogId)await refresh('New punch detected')}catch{} }
$('refresh').onclick=()=>refresh('Manual');
$('setCheckpoint').onclick=async()=>{const v=Number($('checkpointInput').value);if(!Number.isInteger(v)||v<0)return $('checkpointMsg').textContent='Enter a valid DeviceLogId.';if(!confirm('Set LastProcessedDeviceLogId to '+v+'? This does not start resync until you press Start Safe Resync.'))return;try{const j=await getJson('/api/checkpoint',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({lastProcessedDeviceLogId:v})});$('checkpointMsg').textContent='Updated from '+j.oldValue+' to '+j.newValue;showResyncButton(j.newValue);await refresh('Checkpoint changed')}catch(e){$('checkpointMsg').textContent=e.message}};
$('findDate').onclick=async()=>{const date=$('syncDate').value;if(!date)return $('dateResult').textContent='Select a date first.';$('dateResult').textContent='Searching for the first punch...';$('dateAction').innerHTML='';try{const j=await getJson('/api/date-sync',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({date})});$('dateResult').innerHTML='<span class="success">First punch: '+j.firstPunch.logDate+' • Employee: '+esc(j.firstPunch.employeeCode)+' • DeviceLogId: '+j.firstPunch.deviceLogId+' • Device: '+esc(j.firstPunch.deviceId)+'</span><br>Recommended checkpoint: <strong>'+j.recommendedCheckpoint+'</strong>';$('dateAction').innerHTML='<button id="applyDate" class="yellow">Set Sync Point to '+j.recommendedCheckpoint+'</button>';$('applyDate').onclick=async()=>{if(!confirm('Set the sync point to '+j.recommendedCheckpoint+' so syncing begins with DeviceLogId '+j.firstPunch.deviceLogId+'?'))return;try{const r=await getJson('/api/checkpoint',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({lastProcessedDeviceLogId:j.recommendedCheckpoint})});$('dateAction').innerHTML='<span class="success">Sync point updated: '+r.newValue+'</span> <button id="dateResync" class="danger">Start Safe Resync</button>';$('dateResync').onclick=async()=>{if(!confirm('Safely restart syncing from '+r.newValue+'?'))return;try{const rr=await getJson('/api/resync',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({lastProcessedDeviceLogId:r.newValue})});$('dateAction').innerHTML='<span class="success">'+esc(rr.message)+'</span>'}catch(e){$('dateAction').innerHTML='<span class="warn">'+esc(e.message)+'</span>'}};await refresh('Date sync point changed')}catch(e){$('dateAction').innerHTML='<span class="warn">'+esc(e.message)+'</span>'}}}catch(e){$('dateResult').innerHTML='<span class="warn">'+esc(e.message)+'</span>'}};
async function service(action){if(action!=='update'&&!confirm((action==='stop'?'Stop':'Restart')+' the service?'))return;$('serviceMsg').textContent='Requesting '+action+'...';try{const j=await getJson('/api/service/control',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({action})});$('serviceMsg').textContent=j.message||'Done';}catch(e){$('serviceMsg').textContent=e.message}}
$('stop').onclick=()=>service('stop');$('restart').onclick=()=>service('restart');$('update').onclick=()=>service('update');
async function health(){try{const h=await getJson('/api/health');$('health').innerHTML='<span class="dot '+(h.ok?'ok':'bad')+'"></span><span>'+h.database+' • '+h.service+'</span>';$('serviceState').innerHTML='<span class="dot '+(h.service==='Running'?'ok':'bad')+'"></span>'+h.service}catch{$('health').innerHTML='<span class="dot bad"></span><span>Unavailable</span>';$('serviceState').innerHTML='<span class="dot bad"></span>Unavailable'}}
function esc(v){return String(v??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]))}
$('syncDate').value=new Date().toISOString().slice(0,10);refresh('Initial load');health();setInterval(poll,10000);setInterval(()=>refresh('Safe interval'),60000);setInterval(health,30000);
</script></body></html>
""";
}
