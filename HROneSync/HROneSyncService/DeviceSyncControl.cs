using Microsoft.Data.SqlClient;
using System.Net;
using System.Text;
using System.Text.Json;

namespace HROneSyncService;

public sealed class DeviceSyncControl
{
    private readonly string _connectionString;
    private HttpListener? _listener;

    public DeviceSyncControl(string connectionString)
    {
        _connectionString = connectionString;
    }

    public void Start(int port = 8010)
    {
        EnsureSchema();
        _listener = new HttpListener();
        _listener.Prefixes.Add($"http://+:{port}/");
        _listener.Start();
        _ = Task.Run(ListenLoop);
    }

    private async Task ListenLoop()
    {
        while (_listener?.IsListening == true)
        {
            try
            {
                var context = await _listener.GetContextAsync();
                _ = Task.Run(() => Handle(context));
            }
            catch (HttpListenerException) { break; }
            catch (ObjectDisposedException) { break; }
        }
    }

    private async Task Handle(HttpListenerContext context)
    {
        try
        {
            var path = context.Request.Url?.AbsolutePath?.TrimEnd('/').ToLowerInvariant() ?? "";
            if (path == "/api/devices" && context.Request.HttpMethod == "GET")
            {
                await WriteJson(context, await GetDevices(), 200);
                return;
            }
            if (path == "/api/devices/sync" && context.Request.HttpMethod == "POST")
            {
                await SetSync(context);
                return;
            }
            if (path == "/api/devices/all" && context.Request.HttpMethod == "POST")
            {
                await SetAll(context);
                return;
            }
            await WriteHtml(context, BuildHtml(), 200);
        }
        catch (Exception ex)
        {
            await WriteJson(context, new { error = ex.Message, type = ex.GetType().Name }, 500);
        }
        finally { context.Response.Close(); }
    }

    private void EnsureSchema()
    {
        using var c = new SqlConnection(_connectionString);
        c.Open();
        using var cmd = new SqlCommand(@"
IF OBJECT_ID('dbo.HROneDeviceSyncControl','U') IS NULL
BEGIN
    CREATE TABLE dbo.HROneDeviceSyncControl
    (
        DeviceId INT NOT NULL PRIMARY KEY,
        SyncEnabled BIT NOT NULL CONSTRAINT DF_HROneDeviceSyncControl_SyncEnabled DEFAULT(1),
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_HROneDeviceSyncControl_UpdatedAt DEFAULT(GETDATE())
    );
END;
INSERT INTO dbo.HROneDeviceSyncControl(DeviceId, SyncEnabled)
SELECT d.DeviceId, CAST(1 AS bit)
FROM eBioServerNew.dbo.Devices d
WHERE NOT EXISTS (SELECT 1 FROM dbo.HROneDeviceSyncControl x WHERE x.DeviceId=d.DeviceId);", c);
        cmd.CommandTimeout = 15;
        cmd.ExecuteNonQuery();
    }

    public async Task<bool> IsSyncEnabled(int deviceId, CancellationToken token)
    {
        await using var c = new SqlConnection(_connectionString);
        await c.OpenAsync(token);
        await using var cmd = new SqlCommand("SELECT ISNULL((SELECT SyncEnabled FROM dbo.HROneDeviceSyncControl WHERE DeviceId=@DeviceId),0)", c);
        cmd.Parameters.AddWithValue("@DeviceId", deviceId);
        return Convert.ToBoolean(await cmd.ExecuteScalarAsync(token) ?? false);
    }

    private async Task<object> GetDevices()
    {
        await using var c = new SqlConnection(_connectionString);
        await c.OpenAsync();
        const string sql = @"
SELECT d.DeviceId, d.DeviceName,
       ISNULL(x.SyncEnabled,0) AS SyncEnabled,
       x.UpdatedAt,
       p.LastPunch,
       p.TodayCount
FROM eBioServerNew.dbo.Devices d
LEFT JOIN dbo.HROneDeviceSyncControl x ON x.DeviceId=d.DeviceId
OUTER APPLY
(
    SELECT MAX(dl.LogDate) AS LastPunch,
           COUNT_BIG(CASE WHEN CAST(dl.LogDate AS date)=CAST(GETDATE() AS date) THEN 1 END) AS TodayCount
    FROM eBioServerNew.dbo.DeviceLogs dl
    WHERE dl.DeviceId=d.DeviceId
) p
ORDER BY d.DeviceName, d.DeviceId";
        await using var cmd = new SqlCommand(sql, c) { CommandTimeout = 10 };
        await using var r = await cmd.ExecuteReaderAsync();
        var devices = new List<object>();
        while (await r.ReadAsync())
        {
            devices.Add(new
            {
                deviceId = r.GetInt32(0),
                deviceName = r.IsDBNull(1) ? $"Device {r.GetInt32(0)}" : r.GetString(1),
                syncEnabled = r.GetBoolean(2),
                updatedAt = r.IsDBNull(3) ? (DateTime?)null : r.GetDateTime(3),
                lastPunch = r.IsDBNull(4) ? (DateTime?)null : r.GetDateTime(4),
                todayCount = r.IsDBNull(5) ? 0L : r.GetInt64(5)
            });
        }
        return new { ok = true, devices };
    }

    private async Task SetSync(HttpListenerContext context)
    {
        var request = await ReadJson<DeviceSyncRequest>(context);
        if (request is null || request.DeviceId < 0)
        {
            await WriteJson(context, new { error = "A valid DeviceId is required." }, 400);
            return;
        }
        await using var c = new SqlConnection(_connectionString);
        await c.OpenAsync();
        await using var cmd = new SqlCommand(@"
IF EXISTS (SELECT 1 FROM dbo.HROneDeviceSyncControl WHERE DeviceId=@DeviceId)
    UPDATE dbo.HROneDeviceSyncControl SET SyncEnabled=@Enabled, UpdatedAt=GETDATE() WHERE DeviceId=@DeviceId;
ELSE
    INSERT INTO dbo.HROneDeviceSyncControl(DeviceId,SyncEnabled,UpdatedAt) VALUES(@DeviceId,@Enabled,GETDATE());", c);
        cmd.Parameters.AddWithValue("@DeviceId", request.DeviceId);
        cmd.Parameters.AddWithValue("@Enabled", request.Enabled);
        await cmd.ExecuteNonQueryAsync();
        await WriteJson(context, new { success = true, deviceId = request.DeviceId, syncEnabled = request.Enabled }, 200);
    }

    private async Task SetAll(HttpListenerContext context)
    {
        var request = await ReadJson<SetAllRequest>(context);
        if (request is null)
        {
            await WriteJson(context, new { error = "A valid enabled value is required." }, 400);
            return;
        }
        await using var c = new SqlConnection(_connectionString);
        await c.OpenAsync();
        await using var cmd = new SqlCommand("UPDATE dbo.HROneDeviceSyncControl SET SyncEnabled=@Enabled, UpdatedAt=GETDATE()", c);
        cmd.Parameters.AddWithValue("@Enabled", request.Enabled);
        var count = await cmd.ExecuteNonQueryAsync();
        await WriteJson(context, new { success = true, enabled = request.Enabled, affected = count }, 200);
    }

    private sealed class DeviceSyncRequest { public int DeviceId { get; set; } public bool Enabled { get; set; } }
    private sealed class SetAllRequest { public bool Enabled { get; set; } }

    private static async Task<T?> ReadJson<T>(HttpListenerContext context)
    {
        using var body = new StreamReader(context.Request.InputStream, context.Request.ContentEncoding);
        return JsonSerializer.Deserialize<T>(await body.ReadToEndAsync(), new JsonSerializerOptions { PropertyNameCaseInsensitive = true });
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

    private static string BuildHtml() => """
<!doctype html><html><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>ESSL Device Sync Control</title>
<style>
:root{--bg:#080d19;--p:#111827;--p2:#0d1423;--b:#263247;--t:#f4f7ff;--m:#8f9db7;--g:#38d987;--a:#ffc35a;--r:#ff667e;--bl:#78aaff}*{box-sizing:border-box}body{margin:0;background:radial-gradient(circle at top,#101a2d 0,#080d19 46%);color:var(--t);font-family:Segoe UI,Arial,sans-serif}.wrap{max-width:1100px;margin:auto;padding:22px}.panel{background:linear-gradient(180deg,var(--p),var(--p2));border:1px solid var(--b);border-radius:11px;padding:16px;margin-bottom:12px}.head{display:flex;justify-content:space-between;gap:12px;align-items:center;flex-wrap:wrap}.muted{color:var(--m);font-size:12px}.actions{display:flex;gap:7px;flex-wrap:wrap}button{border:0;border-radius:7px;padding:8px 12px;font-weight:750;cursor:pointer}button.on{background:var(--g);color:#07101f}button.off{background:var(--r);color:#fff}button.secondary{background:#253149;color:var(--t);border:1px solid #35435d}table{width:100%;border-collapse:collapse}th,td{padding:10px;border-bottom:1px solid var(--b);text-align:left;font-size:12px}th{color:var(--m);font-size:10px;text-transform:uppercase}tr:last-child td{border-bottom:0}.pill{display:inline-flex;padding:4px 8px;border-radius:99px;font-weight:750;font-size:10px}.enabled{background:rgba(56,217,135,.13);color:var(--g)}.disabled{background:rgba(255,102,126,.13);color:var(--r)}@media(max-width:700px){.wrap{padding:11px}table{min-width:720px}.tablewrap{overflow:auto}}
</style></head><body><main class="wrap"><section class="panel"><div class="head"><div><h2 style="margin:0 0 5px">ESSL Device Sync Control</h2><div class="muted">Choose which biometric machines are allowed to push punches to HROne. Disabling a machine never deletes its ESSL punches.</div></div><div class="actions"><button class="on" onclick="setAll(true)">Enable All</button><button class="off" onclick="setAll(false)">Disable All</button><button class="secondary" onclick="load()">Refresh</button></div></div></section><section class="panel"><div id="msg" class="muted">Loading...</div><div class="tablewrap"><table><thead><tr><th>Device</th><th>Device ID</th><th>Today's Punches</th><th>Last Punch</th><th>HROne Sync</th><th>Action</th></tr></thead><tbody id="rows"></tbody></table></div></section></main><script>
const $=id=>document.getElementById(id);function esc(v){return String(v??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]))}async function api(url,opt={}){const r=await fetch(url+'?t='+Date.now(),{cache:'no-store',...opt});const j=await r.json();if(!r.ok)throw new Error(j.error||'Request failed');return j}function fmt(v){return v?new Date(v).toLocaleString():'—'}async function load(){try{const j=await api('/api/devices');$('msg').textContent=j.devices.length+' device(s) found. Changes apply to the sync worker.';$('rows').innerHTML=j.devices.map(d=>'<tr><td><strong>'+esc(d.deviceName)+'</strong></td><td>'+d.deviceId+'</td><td>'+Number(d.todayCount).toLocaleString()+'</td><td>'+fmt(d.lastPunch)+'</td><td><span class="pill '+(d.syncEnabled?'enabled':'disabled')+'">'+(d.syncEnabled?'ENABLED':'DISABLED')+'</span></td><td><button class="'+(d.syncEnabled?'off':'on')+'" onclick="toggle('+d.deviceId+','+(!d.syncEnabled)+')">'+(d.syncEnabled?'Disable':'Enable')+'</button></td></tr>').join('')}catch(e){$('msg').textContent=e.message}}async function toggle(id,enabled){try{await api('/api/devices/sync',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({deviceId:id,enabled})});await load()}catch(e){alert(e.message)}}async function setAll(enabled){if(!confirm((enabled?'Enable':'Disable')+' HROne sync for all known devices?'))return;try{await api('/api/devices/all',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({enabled})});await load()}catch(e){alert(e.message)}}load();setInterval(load,30000);
</script></body></html>
""";
}
