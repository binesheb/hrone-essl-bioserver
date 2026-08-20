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

    public static void Start(string connectionString, int port = 8009)
    {
        lock (SyncRoot)
        {
            if (_listener?.IsListening == true)
                return;

            _connectionString = connectionString;
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
            try
            {
                var context = await _listener.GetContextAsync();
                _ = Task.Run(() => HandleRequest(context));
            }
            catch (HttpListenerException)
            {
                break;
            }
            catch (ObjectDisposedException)
            {
                break;
            }
        }
    }

    private static async Task HandleRequest(HttpListenerContext context)
    {
        try
        {
            var path = context.Request.Url?.AbsolutePath?.TrimEnd('/').ToLowerInvariant() ?? string.Empty;

            if (path is "/api/data" or "/api/health")
            {
                var data = await GetDashboardData();
                await WriteJson(context, data, 200);
                return;
            }

            if (path is "" or "/")
            {
                await WriteHtml(context, BuildDashboardHtml(), 200);
                return;
            }

            await WriteJson(context, new { error = "Not found" }, 404);
        }
        catch (Exception ex)
        {
            await WriteJson(context, new { error = ex.Message }, 500);
        }
        finally
        {
            context.Response.Close();
        }
    }

    private static async Task WriteJson(HttpListenerContext context, object value, int statusCode)
    {
        var json = JsonSerializer.Serialize(value, new JsonSerializerOptions
        {
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase
        });

        var bytes = Encoding.UTF8.GetBytes(json);
        context.Response.StatusCode = statusCode;
        context.Response.ContentType = "application/json; charset=utf-8";
        context.Response.ContentEncoding = Encoding.UTF8;
        await context.Response.OutputStream.WriteAsync(bytes);
    }

    private static async Task WriteHtml(HttpListenerContext context, string html, int statusCode)
    {
        var bytes = Encoding.UTF8.GetBytes(html);
        context.Response.StatusCode = statusCode;
        context.Response.ContentType = "text/html; charset=utf-8";
        context.Response.ContentEncoding = Encoding.UTF8;
        await context.Response.OutputStream.WriteAsync(bytes);
    }

    private static async Task<object> GetDashboardData()
    {
        await using var connection = new SqlConnection(_connectionString);
        await connection.OpenAsync();

        var lastProcessedId = await ScalarLong(connection,
            "SELECT ISNULL(MAX(LastProcessedDeviceLogId), 0) FROM dbo.HROneSyncState");

        var latestLogId = await ScalarLong(connection,
            "SELECT ISNULL(MAX(DeviceLogId), 0) FROM eBioServerNew.dbo.DeviceLogs");

        var totalToday = await ScalarLong(connection, @"
            SELECT COUNT_BIG(*)
            FROM eBioServerNew.dbo.DeviceLogs
            WHERE CAST(LogDate AS date) = CAST(GETDATE() AS date)");

        var uploadedToday = await ScalarLong(connection, @"
            SELECT COUNT_BIG(*)
            FROM eBioServerNew.dbo.DeviceLogs
            WHERE DeviceLogId <= @LastId
              AND CAST(LogDate AS date) = CAST(GETDATE() AS date)",
            new SqlParameter("@LastId", lastProcessedId));

        var pending = Math.Max(0, latestLogId - lastProcessedId);
        var successRate = totalToday == 0 ? 100 : Math.Round(uploadedToday * 100.0 / totalToday, 1);

        var lastBiometric = await GetLastPunch(connection, null);
        var lastUploaded = await GetLastPunch(connection, lastProcessedId > 0 ? lastProcessedId : null);
        var devices = await GetDevices(connection);
        var recent = await GetRecent(connection, lastProcessedId);
        var byHour = await GetHourlyStats(connection);
        var byDevice = await GetDeviceStats(connection);

        return new
        {
            generatedAt = DateTime.Now,
            health = new
            {
                database = true,
                service = _listener?.IsListening == true,
                pending
            },
            summary = new
            {
                totalToday,
                uploadedToday,
                pending,
                successRate,
                lastProcessedId,
                latestLogId
            },
            lastBiometric,
            lastUploaded,
            devices,
            recent,
            charts = new { byHour, byDevice }
        };
    }

    private static async Task<long> ScalarLong(SqlConnection connection, string sql, params SqlParameter[] parameters)
    {
        await using var command = new SqlCommand(sql, connection);
        command.Parameters.AddRange(parameters);
        var value = await command.ExecuteScalarAsync();
        return value is null or DBNull ? 0 : Convert.ToInt64(value);
    }

    private static async Task<object> GetLastPunch(SqlConnection connection, long? maxId)
    {
        var sql = @"
            SELECT TOP 1 dl.DeviceLogId, dl.EmployeeCode, dl.LogDate,
                   ISNULL(d.DeviceName, 'UNKNOWN') AS DeviceName,
                   ISNULL(dl.Direction, '') AS Direction
            FROM eBioServerNew.dbo.DeviceLogs dl
            LEFT JOIN eBioServerNew.dbo.Devices d ON d.DeviceId = dl.DeviceId
            WHERE (@MaxId IS NULL OR dl.DeviceLogId <= @MaxId)
            ORDER BY dl.DeviceLogId DESC";

        await using var command = new SqlCommand(sql, connection);
        command.Parameters.AddWithValue("@MaxId", maxId.HasValue ? maxId.Value : DBNull.Value);
        await using var reader = await command.ExecuteReaderAsync();

        if (!await reader.ReadAsync())
            return new { id = 0L, employee = "-", machine = "-", direction = "-", time = "-" };

        return new
        {
            id = reader.GetInt64(0),
            employee = reader.IsDBNull(1) ? "-" : reader.GetString(1),
            time = reader.GetDateTime(2).ToString("yyyy-MM-dd HH:mm:ss"),
            machine = reader.IsDBNull(3) ? "UNKNOWN" : reader.GetString(3),
            direction = reader.IsDBNull(4) ? "" : reader.GetString(4)
        };
    }

    private static async Task<List<object>> GetDevices(SqlConnection connection)
    {
        var result = new List<object>();
        const string sql = @"
            SELECT d.DeviceId, ISNULL(d.DeviceName, CONCAT('Device ', d.DeviceId)),
                   MAX(dl.LogDate) AS LastPunch,
                   COUNT(dl.DeviceLogId) AS PunchesToday
            FROM eBioServerNew.dbo.Devices d
            LEFT JOIN eBioServerNew.dbo.DeviceLogs dl
                ON dl.DeviceId = d.DeviceId
               AND CAST(dl.LogDate AS date) = CAST(GETDATE() AS date)
            GROUP BY d.DeviceId, d.DeviceName
            ORDER BY d.DeviceName";

        await using var command = new SqlCommand(sql, connection);
        await using var reader = await command.ExecuteReaderAsync();
        while (await reader.ReadAsync())
        {
            var lastPunch = reader.IsDBNull(2) ? (DateTime?)null : reader.GetDateTime(2);
            var online = lastPunch.HasValue && lastPunch.Value >= DateTime.Now.AddHours(-24);

            result.Add(new
            {
                id = reader.GetInt32(0),
                name = reader.GetString(1),
                lastPunch = lastPunch?.ToString("yyyy-MM-dd HH:mm:ss") ?? "No punch today",
                punchesToday = Convert.ToInt64(reader.GetValue(3)),
                status = online ? "Active" : "No recent activity"
            });
        }

        return result;
    }

    private static async Task<List<object>> GetRecent(SqlConnection connection, long lastProcessedId)
    {
        var result = new List<object>();
        const string sql = @"
            SELECT TOP 25 dl.DeviceLogId, dl.EmployeeCode, dl.LogDate,
                   ISNULL(d.DeviceName, 'UNKNOWN'), ISNULL(dl.Direction, '')
            FROM eBioServerNew.dbo.DeviceLogs dl
            LEFT JOIN eBioServerNew.dbo.Devices d ON d.DeviceId = dl.DeviceId
            ORDER BY dl.DeviceLogId DESC";

        await using var command = new SqlCommand(sql, connection);
        await using var reader = await command.ExecuteReaderAsync();
        while (await reader.ReadAsync())
        {
            var id = reader.GetInt64(0);
            result.Add(new
            {
                id,
                employee = reader.IsDBNull(1) ? "-" : reader.GetString(1),
                time = reader.GetDateTime(2).ToString("yyyy-MM-dd HH:mm:ss"),
                machine = reader.IsDBNull(3) ? "UNKNOWN" : reader.GetString(3),
                direction = reader.IsDBNull(4) ? "" : reader.GetString(4),
                status = id <= lastProcessedId ? "Uploaded" : "Pending"
            });
        }

        return result;
    }

    private static async Task<object> GetHourlyStats(SqlConnection connection)
    {
        var values = new long[24];
        const string sql = @"
            SELECT DATEPART(HOUR, LogDate), COUNT_BIG(*)
            FROM eBioServerNew.dbo.DeviceLogs
            WHERE CAST(LogDate AS date) = CAST(GETDATE() AS date)
            GROUP BY DATEPART(HOUR, LogDate)";

        await using var command = new SqlCommand(sql, connection);
        await using var reader = await command.ExecuteReaderAsync();
        while (await reader.ReadAsync())
            values[reader.GetInt32(0)] = Convert.ToInt64(reader.GetValue(1));

        return new
        {
            labels = Enumerable.Range(0, 24).Select(x => x.ToString("00") + ":00").ToArray(),
            values
        };
    }

    private static async Task<object> GetDeviceStats(SqlConnection connection)
    {
        var labels = new List<string>();
        var values = new List<long>();
        const string sql = @"
            SELECT ISNULL(d.DeviceName, CONCAT('Device ', dl.DeviceId)), COUNT_BIG(*)
            FROM eBioServerNew.dbo.DeviceLogs dl
            LEFT JOIN eBioServerNew.dbo.Devices d ON d.DeviceId = dl.DeviceId
            WHERE CAST(dl.LogDate AS date) = CAST(GETDATE() AS date)
            GROUP BY d.DeviceName, dl.DeviceId
            ORDER BY COUNT_BIG(*) DESC";

        await using var command = new SqlCommand(sql, connection);
        await using var reader = await command.ExecuteReaderAsync();
        while (await reader.ReadAsync())
        {
            labels.Add(reader.GetString(0));
            values.Add(Convert.ToInt64(reader.GetValue(1)));
        }

        return new { labels, values };
    }

    private static string BuildDashboardHtml() => """
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>HROne Sync Dashboard</title>
<style>
:root { color-scheme: dark; --bg:#0b1020; --panel:#131a2b; --border:#26324b; --text:#edf2ff; --muted:#93a1bd; --green:#35d07f; --amber:#ffbe55; --red:#ff647c; --blue:#6ea8fe; }
*{box-sizing:border-box} body{margin:0;font-family:Inter,Segoe UI,Arial,sans-serif;background:var(--bg);color:var(--text)}
header{padding:24px 32px;border-bottom:1px solid var(--border);display:flex;justify-content:space-between;align-items:center;gap:16px;position:sticky;top:0;background:#0b1020eF;backdrop-filter:blur(12px)}
h1{margin:0;font-size:22px}.sub{color:var(--muted);font-size:13px;margin-top:5px}.wrap{max-width:1500px;margin:auto;padding:28px}.grid{display:grid;gap:16px}.cards{grid-template-columns:repeat(auto-fit,minmax(190px,1fr));margin-bottom:16px}.two{grid-template-columns:repeat(auto-fit,minmax(420px,1fr));margin-bottom:16px}.panel{background:var(--panel);border:1px solid var(--border);border-radius:14px;padding:20px}.label{font-size:12px;text-transform:uppercase;letter-spacing:.08em;color:var(--muted)}.value{font-size:28px;font-weight:700;margin-top:8px}.small{font-size:13px;color:var(--muted);margin-top:8px}.row{display:flex;justify-content:space-between;gap:16px;margin:10px 0}.status{padding:5px 10px;border-radius:999px;font-size:12px;font-weight:700;display:inline-block}.ok{background:#143d2a;color:var(--green)}.warn{background:#473719;color:var(--amber)}.bad{background:#4a1d28;color:var(--red)}button{background:var(--blue);color:#081225;border:0;border-radius:9px;padding:10px 16px;font-weight:700;cursor:pointer}table{width:100%;border-collapse:collapse;font-size:13px}th,td{padding:11px 8px;border-bottom:1px solid var(--border);text-align:left;white-space:nowrap}th{color:var(--muted);font-weight:600}.scroll{overflow:auto}.bar{height:10px;background:#202b42;border-radius:999px;overflow:hidden}.bar>span{display:block;height:100%;background:var(--blue);border-radius:inherit}.error{display:none;margin:0 0 16px;padding:12px;border-radius:10px;background:#4a1d28;color:#ffd8df}@media(max-width:600px){header{padding:18px}.wrap{padding:16px}.two{grid-template-columns:1fr}.panel{padding:16px}}
</style>
</head>
<body>
<header><div><h1>HROne Sync Dashboard</h1><div class="sub">ESSL / eBioServer → HROne live synchronization</div></div><div><button onclick="loadData()">Refresh</button></div></header>
<div class="wrap"><div id="error" class="error"></div>
<div class="grid cards">
<div class="panel"><div class="label">Database</div><div id="db" class="value">Checking…</div></div>
<div class="panel"><div class="label">Service</div><div id="service" class="value">Checking…</div></div>
<div class="panel"><div class="label">Today's Punches</div><div id="total" class="value">—</div></div>
<div class="panel"><div class="label">Uploaded Today</div><div id="uploaded" class="value">—</div></div>
<div class="panel"><div class="label">Pending</div><div id="pending" class="value">—</div><div id="ids" class="small"></div></div>
<div class="panel"><div class="label">Success Rate</div><div id="rate" class="value">—</div></div>
</div>
<div class="grid two">
<div class="panel"><div class="label">Latest Biometric Punch</div><div id="bio" class="small">Loading…</div></div>
<div class="panel"><div class="label">Latest Uploaded Punch</div><div id="uploadedPunch" class="small">Loading…</div></div>
</div>
<div class="panel" style="margin-bottom:16px"><div class="label">Punches by Hour</div><div id="hours" style="margin-top:18px"></div></div>
<div class="grid two">
<div class="panel"><div class="label">Device Activity Today</div><div id="devices" class="scroll"><div class="small">Loading…</div></div></div>
<div class="panel"><div class="label">Punches by Device</div><div id="deviceChart" style="margin-top:18px"></div></div>
</div>
<div class="panel"><div class="label">Recent Punches</div><div class="scroll"><table><thead><tr><th>ID</th><th>Time</th><th>Employee</th><th>Machine</th><th>Direction</th><th>Status</th></tr></thead><tbody id="recent"></tbody></table></div></div>
</div>
<script>
const esc=v=>String(v??'').replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
function badge(status){const c=status==='Uploaded'||status==='Active'?'ok':status==='Pending'||status==='No recent activity'?'warn':'bad';return `<span class="status ${c}">${esc(status)}</span>`}
function punch(p){return `<div class="row"><span>Employee</span><b>${esc(p.employee)}</b></div><div class="row"><span>Machine</span><b>${esc(p.machine)}</b></div><div class="row"><span>Direction</span><b>${esc(p.direction||'-')}</b></div><div class="row"><span>Time</span><b>${esc(p.time)}</b></div>`}
function bars(target,labels,values){const max=Math.max(1,...values);document.getElementById(target).innerHTML=labels.map((l,i)=>`<div class="row"><span style="width:110px;overflow:hidden;text-overflow:ellipsis">${esc(l)}</span><div style="flex:1;display:flex;align-items:center;gap:10px"><div class="bar" style="flex:1"><span style="width:${values[i]/max*100}%"></span></div><b>${values[i]}</b></div></div>`).join('')||'<div class="small">No activity today</div>'}
async function loadData(){const error=document.getElementById('error');error.style.display='none';try{const r=await fetch('/api/data',{cache:'no-store'});const d=await r.json();if(!r.ok)throw new Error(d.error||'Dashboard API failed');document.getElementById('db').innerHTML=badge(d.health.database?'Connected':'Error');document.getElementById('service').innerHTML=badge(d.health.service?'Running':'Stopped');document.getElementById('total').textContent=d.summary.totalToday;document.getElementById('uploaded').textContent=d.summary.uploadedToday;document.getElementById('pending').textContent=d.summary.pending;document.getElementById('rate').textContent=d.summary.successRate+'%';document.getElementById('ids').textContent='Processed: '+d.summary.lastProcessedId+' · Latest: '+d.summary.latestLogId;document.getElementById('bio').innerHTML=punch(d.lastBiometric);document.getElementById('uploadedPunch').innerHTML=punch(d.lastUploaded);document.getElementById('devices').innerHTML=`<table><thead><tr><th>Device</th><th>Last Punch</th><th>Today</th><th>Status</th></tr></thead><tbody>${d.devices.map(x=>`<tr><td>${esc(x.name)}</td><td>${esc(x.lastPunch)}</td><td>${x.punchesToday}</td><td>${badge(x.status)}</td></tr>`).join('')}</tbody></table>`;document.getElementById('recent').innerHTML=d.recent.map(x=>`<tr><td>${x.id}</td><td>${esc(x.time)}</td><td>${esc(x.employee)}</td><td>${esc(x.machine)}</td><td>${esc(x.direction||'-')}</td><td>${badge(x.status)}</td></tr>`).join('');bars('hours',d.charts.byHour.labels,d.charts.byHour.values);bars('deviceChart',d.charts.byDevice.labels,d.charts.byDevice.values)}catch(e){error.textContent='Dashboard error: '+e.message;error.style.display='block';console.error(e)}}
loadData();setInterval(loadData,10000);
</script></body></html>
""";
}
