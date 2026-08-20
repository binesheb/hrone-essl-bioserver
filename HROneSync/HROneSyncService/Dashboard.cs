using System.Net;
using System.Text;
using System.Text.Json;
using Microsoft.Data.SqlClient;

namespace HROneSyncService;

public static class DashboardServer
{
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
            if (path is "/api/data" or "/api/health") { await WriteJson(context, await GetDashboardData(), 200); return; }
            if (path == "/api/checkpoint" && context.Request.HttpMethod == "POST") { await SetCheckpoint(context); return; }
            if (path == "/api/service/stop" && context.Request.HttpMethod == "POST") { await RequestStop(context); return; }
            await WriteJson(context, new { error = "Not found" }, 404);
        }
        catch (Exception ex) { await WriteJson(context, new { error = ex.Message }, 500); }
        finally { context.Response.Close(); }
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

        await using var connection = new SqlConnection(_connectionString);
        await connection.OpenAsync();
        await using var transaction = (SqlTransaction)await connection.BeginTransactionAsync();
        try
        {
            long oldValue;
            await using (var read = new SqlCommand("SELECT ISNULL(MAX(LastProcessedDeviceLogId), 0) FROM dbo.HROneSyncState", connection, transaction))
                oldValue = Convert.ToInt64(await read.ExecuteScalarAsync());

            await using (var update = new SqlCommand(@"
IF EXISTS (SELECT 1 FROM dbo.HROneSyncState)
    UPDATE dbo.HROneSyncState SET LastProcessedDeviceLogId = @Value;
ELSE
    INSERT INTO dbo.HROneSyncState (LastProcessedDeviceLogId) VALUES (@Value);", connection, transaction))
            {
                update.Parameters.AddWithValue("@Value", request.LastProcessedDeviceLogId);
                await update.ExecuteNonQueryAsync();
            }
            await transaction.CommitAsync();
            await WriteJson(context, new { success = true, oldValue, newValue = request.LastProcessedDeviceLogId, message = "Checkpoint updated. The next worker cycle will resume from this position." }, 200);
        }
        catch { await transaction.RollbackAsync(); throw; }
    }

    private static async Task RequestStop(HttpListenerContext context)
    {
        if (_stopApplication is null)
        {
            await WriteJson(context, new { error = "Service stop control is not configured." }, 503); return;
        }
        await WriteJson(context, new { success = true, message = "Stop requested. The service is shutting down." }, 200);
        _ = Task.Run(async () => { await Task.Delay(750); _stopApplication(); });
    }

    private sealed class CheckpointRequest { public long LastProcessedDeviceLogId { get; set; } }

    private static async Task WriteJson(HttpListenerContext context, object value, int statusCode)
    {
        var bytes = Encoding.UTF8.GetBytes(JsonSerializer.Serialize(value, new JsonSerializerOptions { PropertyNamingPolicy = JsonNamingPolicy.CamelCase }));
        context.Response.StatusCode = statusCode; context.Response.ContentType = "application/json; charset=utf-8";
        await context.Response.OutputStream.WriteAsync(bytes);
    }
    private static async Task WriteHtml(HttpListenerContext context, string html, int statusCode)
    {
        var bytes = Encoding.UTF8.GetBytes(html); context.Response.StatusCode = statusCode; context.Response.ContentType = "text/html; charset=utf-8";
        await context.Response.OutputStream.WriteAsync(bytes);
    }

    private static async Task<object> GetDashboardData()
    {
        await using var c = new SqlConnection(_connectionString); await c.OpenAsync();
        var last = await ScalarLong(c, "SELECT ISNULL(MAX(LastProcessedDeviceLogId),0) FROM dbo.HROneSyncState");
        var latest = await ScalarLong(c, "SELECT ISNULL(MAX(DeviceLogId),0) FROM eBioServerNew.dbo.DeviceLogs");
        var today = await ScalarLong(c, "SELECT COUNT_BIG(*) FROM eBioServerNew.dbo.DeviceLogs WHERE CAST(LogDate AS date)=CAST(GETDATE() AS date)");
        var uploaded = await ScalarLong(c, "SELECT COUNT_BIG(*) FROM eBioServerNew.dbo.DeviceLogs WHERE DeviceLogId<=@LastId AND CAST(LogDate AS date)=CAST(GETDATE() AS date)", new SqlParameter("@LastId", last));
        return new { generatedAt = DateTime.Now, health = new { database = true, service = _listener?.IsListening == true }, summary = new { totalToday = today, uploadedToday = uploaded, pending = Math.Max(0, latest - last), successRate = today == 0 ? 100 : Math.Round(uploaded * 100.0 / today, 1), lastProcessedId = last, latestLogId = latest }, recent = await GetRecent(c, last) };
    }

    private static async Task<long> ScalarLong(SqlConnection c, string sql, params SqlParameter[] p)
    {
        await using var cmd = new SqlCommand(sql, c); cmd.Parameters.AddRange(p); var v = await cmd.ExecuteScalarAsync(); return v is null or DBNull ? 0 : Convert.ToInt64(v);
    }
    private static async Task<List<object>> GetRecent(SqlConnection c, long last)
    {
        var r = new List<object>();
        await using var cmd = new SqlCommand("SELECT TOP 25 DeviceLogId,EmployeeCode,LogDate,DeviceId FROM eBioServerNew.dbo.DeviceLogs ORDER BY DeviceLogId DESC", c);
        await using var rd = await cmd.ExecuteReaderAsync();
        while (await rd.ReadAsync()) r.Add(new { id = rd.GetInt64(0), employee = rd.IsDBNull(1) ? "-" : rd.GetString(1), time = rd.GetDateTime(2).ToString("yyyy-MM-dd HH:mm:ss"), machine = rd.GetValue(3).ToString(), status = rd.GetInt64(0) <= last ? "Uploaded" : "Pending" });
        return r;
    }

    private static string BuildDashboardHtml() => """
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>HROne Sync Dashboard</title><style>
:root{--bg:#0b1020;--p:#131a2b;--b:#26324b;--t:#edf2ff;--m:#93a1bd;--g:#35d07f;--a:#ffbe55;--r:#ff647c;--bl:#6ea8fe}*{box-sizing:border-box}body{margin:0;font-family:Segoe UI,Arial;background:var(--bg);color:var(--t)}header{padding:20px 30px;border-bottom:1px solid var(--b);display:flex;justify-content:space-between;gap:12px;align-items:center}.wrap{max-width:1400px;margin:auto;padding:24px}.grid{display:grid;gap:16px}.cards{grid-template-columns:repeat(auto-fit,minmax(190px,1fr))}.panel{background:var(--p);border:1px solid var(--b);border-radius:14px;padding:18px;margin-bottom:16px}.label{font-size:12px;color:var(--m);text-transform:uppercase}.value{font-size:30px;font-weight:700;margin-top:7px}button{border:0;border-radius:8px;padding:10px 14px;font-weight:700;cursor:pointer;background:var(--bl)}button.danger{background:var(--r)}input{background:#0b1020;color:var(--t);border:1px solid var(--b);border-radius:8px;padding:10px;width:100%;margin:8px 0}.msg{margin-top:8px;color:var(--m)}table{width:100%;border-collapse:collapse}th,td{padding:10px;border-bottom:1px solid var(--b);text-align:left}.scroll{overflow:auto}.ok{color:var(--g)}.warn{color:var(--a)}.error{color:var(--r)}.actions{display:grid;grid-template-columns:1fr 1fr;gap:16px}@media(max-width:700px){.actions{grid-template-columns:1fr}}
</style></head><body><header><div><b>HROne Sync Dashboard</b><div class="msg">ESSL / eBioServer → HROne</div></div><button onclick="load()">Refresh</button></header><div class="wrap"><div class="grid cards"><div class="panel"><div class="label">Today's Punches</div><div id="total" class="value">—</div></div><div class="panel"><div class="label">Uploaded</div><div id="uploaded" class="value">—</div></div><div class="panel"><div class="label">Pending</div><div id="pending" class="value">—</div></div><div class="panel"><div class="label">Success Rate</div><div id="rate" class="value">—</div></div></div><div class="actions"><div class="panel"><div class="label">Reset Sync Checkpoint</div><p class="msg">Set LastProcessedDeviceLogId. The worker will process entries after this ID again.</p><input id="checkpoint" type="number" min="0" placeholder="DeviceLogId"><button onclick="setCheckpoint()">Update Checkpoint</button><div id="checkpointMsg" class="msg"></div></div><div class="panel"><div class="label">Service Control</div><p class="msg">Stops the application cleanly. Windows Service Recovery can start it again if configured.</p><button class="danger" onclick="stopService()">Stop Service</button><div id="stopMsg" class="msg"></div></div></div><div class="panel"><div class="label">Recent Punches</div><div class="scroll"><table><thead><tr><th>ID</th><th>Time</th><th>Employee</th><th>Device</th><th>Status</th></tr></thead><tbody id="recent"></tbody></table></div></div></div><script>
const $=id=>document.getElementById(id);async function load(){try{const r=await fetch('/api/data',{cache:'no-store'}),d=await r.json();if(!r.ok)throw Error(d.error);$('total').textContent=d.summary.totalToday;$('uploaded').textContent=d.summary.uploadedToday;$('pending').textContent=d.summary.pending;$('rate').textContent=d.summary.successRate+'%';$('checkpoint').value=d.summary.lastProcessedId;$('recent').innerHTML=d.recent.map(x=>`<tr><td>${x.id}</td><td>${x.time}</td><td>${x.employee}</td><td>${x.machine}</td><td class="${x.status==='Uploaded'?'ok':'warn'}">${x.status}</td></tr>`).join('')}catch(e){console.error(e)}}async function setCheckpoint(){const v=Number($('checkpoint').value);if(!Number.isInteger(v)||v<0)return $('checkpointMsg').textContent='Enter a valid non-negative DeviceLogId.';if(!confirm('Set LastProcessedDeviceLogId to '+v+'? This may cause previous punches to sync again.'))return;const r=await fetch('/api/checkpoint',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({lastProcessedDeviceLogId:v})}),d=await r.json();$('checkpointMsg').textContent=d.success?`Updated: ${d.oldValue} → ${d.newValue}`:(d.error||'Update failed');load()}async function stopService(){if(!confirm('Stop HROne Sync Service now? Attendance synchronization will stop.'))return;const r=await fetch('/api/service/stop',{method:'POST'}),d=await r.json();$('stopMsg').textContent=d.message||d.error}load();setInterval(load,10000);
</script></body></html>
""";
}
