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
            var path = context.Request.Url?.AbsolutePath?.TrimEnd('/').ToLowerInvariant() ?? string.Empty;
            if (path is "" or "/") { await WriteHtml(context, BuildDashboardHtml(), 200); return; }
            if (path == "/api/data" && context.Request.HttpMethod == "GET") { await WriteJson(context, await GetDashboardData(), 200); return; }
            if (path == "/api/health" && context.Request.HttpMethod == "GET") { await WriteJson(context, await GetHealth(), 200); return; }
            if (path == "/api/checkpoint" && context.Request.HttpMethod == "POST") { await SetCheckpoint(context); return; }
            if (path == "/api/service/control" && context.Request.HttpMethod == "POST") { await ServiceControl(context); return; }
            await WriteJson(context, new { error = "Not found", path }, 404);
        }
        catch (Exception ex) { await WriteJson(context, new { error = ex.Message, type = ex.GetType().Name }, 500); }
        finally { context.Response.Close(); }
    }

    private static async Task<object> GetHealth()
    {
        try
        {
            await using var c = await OpenConnection();
            return new { ok = true, database = "Connected", service = GetServiceStatus(), checkedAt = DateTime.Now };
        }
        catch (Exception ex)
        {
            return new { ok = false, database = "Failed", service = GetServiceStatus(), error = ex.Message, type = ex.GetType().Name, checkedAt = DateTime.Now };
        }
    }

    private static async Task SetCheckpoint(HttpListenerContext context)
    {
        using var body = new StreamReader(context.Request.InputStream, context.Request.ContentEncoding);
        var json = await body.ReadToEndAsync();
        var request = JsonSerializer.Deserialize<CheckpointRequest>(json, new JsonSerializerOptions { PropertyNameCaseInsensitive = true });
        if (request is null || request.LastProcessedDeviceLogId < 0)
        {
            await WriteJson(context, new { error = "A valid LastProcessedDeviceLogId is required." }, 400); return;
        }

        await using var connection = await OpenConnection();
        await using var transaction = (SqlTransaction)await connection.BeginTransactionAsync();
        try
        {
            long oldValue;
            await using (var read = new SqlCommand("SELECT ISNULL(MAX(LastProcessedDeviceLogId),0) FROM dbo.HROneSyncState", connection, transaction))
                oldValue = Convert.ToInt64(await read.ExecuteScalarAsync());
            await using (var update = new SqlCommand(@"IF EXISTS (SELECT 1 FROM dbo.HROneSyncState)
UPDATE dbo.HROneSyncState SET LastProcessedDeviceLogId=@Value;
ELSE INSERT INTO dbo.HROneSyncState (LastProcessedDeviceLogId) VALUES (@Value);", connection, transaction))
            {
                update.Parameters.AddWithValue("@Value", request.LastProcessedDeviceLogId);
                await update.ExecuteNonQueryAsync();
            }
            await transaction.CommitAsync();
            await WriteJson(context, new { success = true, oldValue, newValue = request.LastProcessedDeviceLogId, message = "Checkpoint updated. The next worker cycle will resume from this position." }, 200);
        }
        catch { await transaction.RollbackAsync(); throw; }
    }

    private static async Task ServiceControl(HttpListenerContext context)
    {
        using var body = new StreamReader(context.Request.InputStream, context.Request.ContentEncoding);
        var json = await body.ReadToEndAsync();
        var request = JsonSerializer.Deserialize<ServiceControlRequest>(json, new JsonSerializerOptions { PropertyNameCaseInsensitive = true });
        var action = request?.Action?.Trim().ToLowerInvariant();
        if (action is not ("stop" or "restart" or "update"))
        {
            await WriteJson(context, new { error = "Action must be stop, restart, or update." }, 400); return;
        }

        var config = ConfigureServiceToCurrentExecutable();
        if (!config.Success)
        {
            await WriteJson(context, new { success = false, action, message = config.Message }, 500); return;
        }

        if (action == "update")
        {
            await WriteJson(context, new { success = true, action, message = "Windows service path updated to the currently running executable.", path = CurrentExecutablePath() }, 200);
            return;
        }

        if (_stopApplication is null)
        {
            await WriteJson(context, new { error = "Service lifecycle control is not configured." }, 503); return;
        }

        if (action == "stop")
        {
            await WriteJson(context, new { success = true, action, message = "Stop requested. The service is shutting down." }, 200);
            _ = Task.Run(async () => { await Task.Delay(750); _stopApplication(); });
            return;
        }

        await WriteJson(context, new { success = true, action, message = "Restart requested. The service will stop and start again." }, 200);
        _ = Task.Run(async () =>
        {
            await Task.Delay(750);
            ScheduleServiceStart();
            _stopApplication();
        });
    }

    private static (bool Success, string Message) ConfigureServiceToCurrentExecutable()
    {
        var exe = CurrentExecutablePath();
        if (!File.Exists(exe)) return (false, $"Current service executable was not found: {exe}");
        var result = RunSc("config", ServiceName, "binPath=", $"\"{exe}\"", "start=", "auto");
        return result.ExitCode == 0 ? (true, result.Output) : (false, $"Service configuration failed ({result.ExitCode}): {result.Output}");
    }

    private static string CurrentExecutablePath() => Path.GetFullPath(Path.Combine(AppContext.BaseDirectory, "HROneSyncService.exe"));

    private static void ScheduleServiceStart()
    {
        try
        {
            var psi = new ProcessStartInfo { FileName = "cmd.exe", UseShellExecute = false, CreateNoWindow = true, WindowStyle = ProcessWindowStyle.Hidden };
            psi.ArgumentList.Add("/c");
            psi.ArgumentList.Add("timeout /t 3 /nobreak >nul & sc.exe start HROneSyncService >nul");
            Process.Start(psi);
        }
        catch { }
    }

    private static string GetServiceStatus()
    {
        var result = RunSc("query", ServiceName);
        if (result.ExitCode != 0) return "Not installed";
        if (result.Output.Contains("RUNNING", StringComparison.OrdinalIgnoreCase)) return "Running";
        if (result.Output.Contains("STOPPED", StringComparison.OrdinalIgnoreCase)) return "Stopped";
        return "Transitioning";
    }

    private static (int ExitCode, string Output) RunSc(params string[] arguments)
    {
        try
        {
            var psi = new ProcessStartInfo { FileName = "sc.exe", UseShellExecute = false, RedirectStandardOutput = true, RedirectStandardError = true, CreateNoWindow = true };
            foreach (var argument in arguments) psi.ArgumentList.Add(argument);
            using var process = Process.Start(psi);
            if (process is null) return (-1, "Unable to start sc.exe.");
            var output = process.StandardOutput.ReadToEnd();
            var error = process.StandardError.ReadToEnd();
            process.WaitForExit(10000);
            return (process.ExitCode, string.IsNullOrWhiteSpace(error) ? output.Trim() : error.Trim());
        }
        catch (Exception ex) { return (-1, ex.Message); }
    }

    private sealed class CheckpointRequest { public long LastProcessedDeviceLogId { get; set; } }
    private sealed class ServiceControlRequest { public string? Action { get; set; } }

    private static async Task<SqlConnection> OpenConnection()
    {
        var builder = new SqlConnectionStringBuilder(_connectionString) { ConnectTimeout = 5 };
        var c = new SqlConnection(builder.ConnectionString);
        await c.OpenAsync();
        return c;
    }

    private static async Task WriteJson(HttpListenerContext context, object value, int statusCode)
    {
        var bytes = Encoding.UTF8.GetBytes(JsonSerializer.Serialize(value, new JsonSerializerOptions { PropertyNamingPolicy = JsonNamingPolicy.CamelCase }));
        context.Response.StatusCode = statusCode;
        context.Response.ContentType = "application/json; charset=utf-8";
        context.Response.Headers["Cache-Control"] = "no-store, no-cache, must-revalidate";
        await context.Response.OutputStream.WriteAsync(bytes);
    }

    private static async Task WriteHtml(HttpListenerContext context, string html, int statusCode)
    {
        var bytes = Encoding.UTF8.GetBytes(html);
        context.Response.StatusCode = statusCode;
        context.Response.ContentType = "text/html; charset=utf-8";
        context.Response.Headers["Cache-Control"] = "no-store, no-cache, must-revalidate";
        await context.Response.OutputStream.WriteAsync(bytes);
    }

    private static async Task<object> GetDashboardData()
    {
        try
        {
            await using var c = await OpenConnection();
            var last = await ScalarLong(c, "SELECT ISNULL(MAX(LastProcessedDeviceLogId),0) FROM dbo.HROneSyncState");
            var latest = await ScalarLong(c, "SELECT ISNULL(MAX(DeviceLogId),0) FROM eBioServerNew.dbo.DeviceLogs");
            var today = await ScalarLong(c, "SELECT COUNT_BIG(*) FROM eBioServerNew.dbo.DeviceLogs WHERE CAST(LogDate AS date)=CAST(GETDATE() AS date)");
            var uploaded = await ScalarLong(c, "SELECT COUNT_BIG(*) FROM eBioServerNew.dbo.DeviceLogs WHERE DeviceLogId<=@LastId AND CAST(LogDate AS date)=CAST(GETDATE() AS date)", new SqlParameter("@LastId", last));
            return new { ok = true, generatedAt = DateTime.Now, health = new { database = true, service = GetServiceStatus() }, summary = new { totalToday = today, uploadedToday = uploaded, pending = Math.Max(0, latest - last), successRate = today == 0 ? 100 : Math.Round(uploaded * 100.0 / today, 1), lastProcessedId = last, latestLogId = latest }, recent = await GetRecent(c, last) };
        }
        catch (Exception ex)
        {
            return new { ok = false, generatedAt = DateTime.Now, error = ex.Message, type = ex.GetType().Name, summary = new { totalToday = 0L, uploadedToday = 0L, pending = 0L, successRate = 0d, lastProcessedId = 0L, latestLogId = 0L }, recent = Array.Empty<object>() };
        }
    }

    private static async Task<long> ScalarLong(SqlConnection c, string sql, params SqlParameter[] p)
    {
        await using var cmd = new SqlCommand(sql, c) { CommandTimeout = 10 };
        cmd.Parameters.AddRange(p);
        var v = await cmd.ExecuteScalarAsync();
        return v is null or DBNull ? 0 : Convert.ToInt64(v);
    }

    private static async Task<List<object>> GetRecent(SqlConnection c, long last)
    {
        var r = new List<object>();
        await using var cmd = new SqlCommand("SELECT TOP 25 DeviceLogId,EmployeeCode,LogDate,DeviceId FROM eBioServerNew.dbo.DeviceLogs ORDER BY DeviceLogId DESC", c) { CommandTimeout = 10 };
        await using var rd = await cmd.ExecuteReaderAsync();
        while (await rd.ReadAsync()) r.Add(new { id = rd.GetInt64(0), employee = rd.IsDBNull(1) ? "-" : rd.GetString(1), time = rd.GetDateTime(2).ToString("yyyy-MM-dd HH:mm:ss"), machine = rd.GetValue(3).ToString(), status = rd.GetInt64(0) <= last ? "Uploaded" : "Pending" });
        return r;
    }

    private static string BuildDashboardHtml() => """
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>HROne Sync Dashboard</title><style>
:root{--bg:#0b1020;--p:#131a2b;--b:#26324b;--t:#edf2ff;--m:#93a1bd;--g:#35d07f;--a:#ffbe55;--r:#ff647c;--bl:#6ea8fe}*{box-sizing:border-box}body{margin:0;font-family:Segoe UI,Arial;background:var(--bg);color:var(--t)}header{padding:20px 30px;border-bottom:1px solid var(--b);display:flex;justify-content:space-between;gap:12px;align-items:center}.wrap{max-width:1400px;margin:auto;padding:24px}.grid{display:grid;gap:16px}.cards{grid-template-columns:repeat(auto-fit,minmax(190px,1fr))}.panel{background:var(--p);border:1px solid var(--b);border-radius:14px;padding:18px;margin-bottom:16px}.label{font-size:12px;color:var(--m);text-transform:uppercase}.value{font-size:30px;font-weight:700;margin-top:7px}button,select{border:0;border-radius:8px;padding:10px 14px;font-weight:700;cursor:pointer;background:var(--bl);color:#07101f}button.danger{background:var(--r);color:#fff}button.green{background:var(--g)}button.yellow{background:var(--a)}select{border:1px solid var(--b);background:#0b1020;color:var(--t)}input{background:#0b1020;color:var(--t);border:1px solid var(--b);border-radius:8px;padding:10px;width:100%;margin:8px 0}.msg{margin-top:8px;color:var(--m)}.errorbox{background:#3a1720;border:1px solid var(--r);padding:14px;border-radius:10px;margin-bottom:16px}.health{display:flex;gap:10px;align-items:center;flex-wrap:wrap}.dot{width:10px;height:10px;border-radius:50%;display:inline-block;background:var(--a)}.dot.ok{background:var(--g)}.dot.bad{background:var(--r)}table{width:100%;border-collapse:collapse}th,td{padding:10px;border-bottom:1px solid var(--b);text-align:left}.scroll{overflow:auto}.ok{color:var(--g)}.warn{color:var(--a)}.actions{display:grid;grid-template-columns:1fr 1fr;gap:16px}.service-buttons{display:flex;gap:10px;flex-wrap:wrap}.refreshbar{display:flex;gap:10px;align-items:center;flex-wrap:wrap}@media(max-width:700px){.actions{grid-template-columns:1fr}header{align-items:flex-start;flex-direction:column}}
</style></head><body><header><div><b>HROne Sync Dashboard</b><div class="msg">ESSL / eBioServer → HROne</div></div><div class="health"><span id="healthDot" class="dot"></span><span id="healthText">Checking...</span><button onclick="load()">Refresh now</button></div></header><div class="wrap"><div id="errorBox" class="errorbox" style="display:none"></div><div class="grid cards"><div class="panel"><div class="label">Today's Punches</div><div id="total" class="value">—</div></div><div class="panel"><div class="label">Uploaded</div><div id="uploaded" class="value">—</div></div><div class="panel"><div class="label">Pending</div><div id="pending" class="value">—</div></div><div class="panel"><div class="label">Success Rate</div><div id="rate" class="value">—</div></div></div><div class="panel"><div class="label">Dashboard Refresh</div><div class="refreshbar"><span>Safe interval</span><select id="refreshInterval" onchange="setRefresh(this.value)"><option value="0">Off</option><option value="10000">10 sec</option><option value="30000" selected>30 sec</option><option value="60000">1 min</option><option value="120000">2 min</option><option value="300000">5 min</option></select><span class="msg">Next: <b id="nextRefresh">—</b></span></div></div><div class="actions"><div class="panel"><div class="label">Sync Checkpoint</div><p class="msg">Set LastProcessedDeviceLogId. Entries after this ID will be processed again.</p><input id="checkpoint" type="number" min="0" placeholder="DeviceLogId"><button onclick="setCheckpoint()">Update Checkpoint</button><div id="checkpointMsg" class="msg"></div></div><div class="panel"><div class="label">Service Control</div><p class="msg">Control this Windows service instance.</p><div class="service-buttons"><button class="danger" onclick="serviceAction('stop')">Stop Service</button><button class="green" onclick="serviceAction('restart')">Restart Service</button><button class="yellow" onclick="serviceAction('update')">Update Service</button></div><div id="serviceMsg" class="msg"></div><div class="msg">Status: <b id="serviceStatus">Checking...</b></div></div></div><div class="panel"><div class="label">Recent Punches</div><div class="scroll"><table><thead><tr><th>ID</th><th>Time</th><th>Employee</th><th>Device</th><th>Status</th></tr></thead><tbody id="recent"><tr><td colspan="5">Loading...</td></tr></tbody></table></div></div><div class="msg">Last updated: <span id="updated">—</span></div></div><script>
const $=id=>document.getElementById(id);let timer=null,countTimer=null,loading=false;function esc(v){return String(v??'').replace(/[&<>\"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','\"':'&quot;',"'":'&#39;'}[c]))}function setRefresh(v,save=true){const ms=Number(v)||0;if(timer)clearInterval(timer);if(countTimer)clearInterval(countTimer);timer=null;countTimer=null;if(save)localStorage.setItem('hroneRefresh',String(ms));$('refreshInterval').value=String(ms);if(!ms){$('nextRefresh').textContent='Off';return}let left=Math.ceil(ms/1000);$('nextRefresh').textContent=left+'s';timer=setInterval(()=>{if(!document.hidden)load()},ms);countTimer=setInterval(()=>{left--;if(left<=0)left=Math.ceil(ms/1000);$('nextRefresh').textContent=left+'s'},1000)}async function load(){if(loading)return;loading=true;try{const r=await fetch('/api/data?t='+Date.now(),{cache:'no-store'}),d=await r.json();$('updated').textContent=new Date().toLocaleString();$('serviceStatus').textContent=d.health?.service||'Unknown';if(!d.ok){$('healthDot').className='dot bad';$('healthText').textContent='Database error';$('errorBox').style.display='block';$('errorBox').textContent='Dashboard data error: '+d.type+': '+d.error;return}$('errorBox').style.display='none';$('healthDot').className='dot ok';$('healthText').textContent='Database connected';$('total').textContent=d.summary.totalToday;$('uploaded').textContent=d.summary.uploadedToday;$('pending').textContent=d.summary.pending;$('rate').textContent=d.summary.successRate+'%';$('checkpoint').value=d.summary.lastProcessedId;$('recent').innerHTML=d.recent.length?d.recent.map(x=>`<tr><td>${esc(x.id)}</td><td>${esc(x.time)}</td><td>${esc(x.employee)}</td><td>${esc(x.machine)}</td><td class="${x.status==='Uploaded'?'ok':'warn'}">${esc(x.status)}</td></tr>`).join(''):'<tr><td colspan="5">No punches found.</td></tr>'}catch(e){$('healthDot').className='dot bad';$('healthText').textContent='Dashboard API error';$('errorBox').style.display='block';$('errorBox').textContent='Cannot read dashboard API: '+e}finally{loading=false}}async function setCheckpoint(){const v=Number($('checkpoint').value);if(!Number.isInteger(v)||v<0){$('checkpointMsg').textContent='Enter a valid non-negative DeviceLogId.';return}if(!confirm('Set LastProcessedDeviceLogId to '+v+'? Previous punches may sync again.'))return;const r=await fetch('/api/checkpoint',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({lastProcessedDeviceLogId:v})}),d=await r.json();$('checkpointMsg').textContent=d.success?`Updated: ${d.oldValue} → ${d.newValue}`:(d.error||'Update failed');load()}async function serviceAction(action){const text={stop:'Stop the HROne Sync service now?',restart:'Restart the HROne Sync service now?',update:'Update the Windows service to this currently running executable?'}[action];if(!confirm(text))return;$('serviceMsg').textContent='Working...';try{const r=await fetch('/api/service/control',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({action})}),d=await r.json();$('serviceMsg').textContent=d.message||d.error||'Completed';if(action!=='update')setTimeout(()=>location.reload(),5000);else load()}catch(e){$('serviceMsg').textContent='Service control error: '+e}}const saved=localStorage.getItem('hroneRefresh');setRefresh(saved??'30000',false);load();document.addEventListener('visibilitychange',()=>{if(!document.hidden)load()});
</script></body></html>
""";
}
