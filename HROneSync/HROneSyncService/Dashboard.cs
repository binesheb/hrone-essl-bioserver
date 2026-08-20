using System.Net;
using System.Text;
using System.Text.Json;
using Microsoft.Data.SqlClient;

namespace HROneSyncService
{
    public static class DashboardServer
    {
        private static HttpListener? _listener;
        private static string _connectionString = "";

        public static void Start(string connectionString, int port = 8009)
        {
            _connectionString = connectionString;

            _listener = new HttpListener();
            _listener.Prefixes.Add($"http://+:{port}/");
            _listener.Start();

            Task.Run(ListenLoop);
        }

        private static async Task ListenLoop()
        {
            while (_listener!.IsListening)
            {
                var ctx = await _listener.GetContextAsync();
                _ = Task.Run(() => HandleRequest(ctx));
            }
        }

        private static void HandleRequest(HttpListenerContext ctx)
        {
            try
            {
                string path = ctx.Request.Url?.AbsolutePath?.ToLower() ?? "/";

                if (path == "/api/data")
                {
                    HandleApi(ctx);
                    return;
                }

                string html = BuildDashboardHtml();
                byte[] buffer = Encoding.UTF8.GetBytes(html);

                ctx.Response.ContentType = "text/html; charset=utf-8";
                ctx.Response.ContentEncoding = Encoding.UTF8;
                ctx.Response.OutputStream.Write(buffer, 0, buffer.Length);
            }
            catch
            {
                // ignore
            }
            finally
            {
                ctx.Response.OutputStream.Close();
            }
        }

        private static void HandleApi(HttpListenerContext ctx)
        {
            try
            {
                var lastBio = GetLastBiometricPunch();
                var lastHr = GetLastHROnePunch();
                var summary = GetSyncSummary();
                var devices = GetDeviceStatsRaw();
                var recent = GetRecentPunchesRaw();
                var charts = GetChartData();

                var payload = new
                {
                    lastBiometric = lastBio,
                    lastHROne = lastHr,
                    summary,
                    devices,
                    recent,
                    charts
                };

                string json = JsonSerializer.Serialize(payload);
                byte[] buffer = Encoding.UTF8.GetBytes(json);

                ctx.Response.ContentType = "application/json; charset=utf-8";
                ctx.Response.ContentEncoding = Encoding.UTF8;
                ctx.Response.OutputStream.Write(buffer, 0, buffer.Length);
            }
            catch
            {
                // ignore
            }
            finally
            {
                ctx.Response.OutputStream.Close();
            }
        }

        private static string BuildDashboardHtml()
        {
            return @"
<!DOCTYPE html>
<html lang='en'>
<head>
    <meta charset='utf-8' />
    <title>HROne Sync Dashboard</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>

    <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css'>

    <style>
        :root {
            color-scheme: light dark;
        }
        body {
            background-color: var(--bs-body-bg);
            color: var(--bs-body-color);
        }
        .card {
            border-radius: 0.75rem;
        }
        .table thead th {
            white-space: nowrap;
        }
        .chart-card {
            min-height: 320px;
        }
    </style>
</head>
<body class='bg-body'>

<div class='container-fluid py-4'>
    <div class='d-flex justify-content-between align-items-center mb-4'>
        <h3 class='mb-0'>HROne Sync Dashboard</h3>
        <span class='text-muted small'>Auto light/dark · Port 8009</span>
    </div>

    <!-- Row 1: Summary cards -->
    <div class='row g-3 mb-3'>
        <div class='col-md-4'>
            <div class='card shadow-sm h-100'>
                <div class='card-body'>
                    <h6 class='card-title mb-3'>Last Biometric Punch</h6>
                    <p class='mb-1'><strong>Employee:</strong> <span id='bio-emp'>-</span></p>
                    <p class='mb-1'><strong>Machine:</strong> <span id='bio-mach'>-</span></p>
                    <p class='mb-0'><strong>Time:</strong> <span id='bio-time'>-</span></p>
                </div>
            </div>
        </div>

        <div class='col-md-4'>
            <div class='card shadow-sm h-100'>
                <div class='card-body'>
                    <h6 class='card-title mb-3'>Last HRONE Upload</h6>
                    <p class='mb-1'><strong>Employee:</strong> <span id='hr-emp'>-</span></p>
                    <p class='mb-1'><strong>Machine:</strong> <span id='hr-mach'>-</span></p>
                    <p class='mb-1'><strong>Uploaded:</strong> <span id='hr-time'>-</span></p>
                    <p class='mb-0'><strong>Status:</strong> <span id='hr-status'>-</span></p>
                </div>
            </div>
        </div>

        <div class='col-md-4'>
            <div class='card shadow-sm h-100'>
                <div class='card-body'>
                    <h6 class='card-title mb-3'>Sync Summary (Today)</h6>
                    <p class='mb-1'><strong>Total Punches:</strong> <span id='sum-total'>-</span></p>
                    <p class='mb-1'><strong>Uploaded:</strong> <span id='sum-uploaded'>-</span></p>
                    <p class='mb-1'><strong>Failed:</strong> <span id='sum-failed'>-</span></p>
                    <p class='mb-0'><strong>Success Rate:</strong> <span id='sum-rate'>-</span></p>
                </div>
            </div>
        </div>
    </div>

    <!-- Row 2: Device status -->
    <div class='row g-3 mb-3'>
        <div class='col-12'>
            <div class='card shadow-sm'>
                <div class='card-body'>
                    <h6 class='card-title mb-3'>Device Status</h6>
                    <div class='table-responsive'>
                        <table class='table table-sm table-striped align-middle mb-0'>
                            <thead>
                                <tr>
                                    <th>Device</th>
                                    <th>Direction</th>
                                    <th>Last Ping</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody id='device-body'>
                                <tr><td colspan='4' class='text-center text-muted'>Loading...</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Row 3: Charts -->
    <div class='row g-3 mb-3'>
        <div class='col-lg-4'>
            <div class='card shadow-sm chart-card'>
                <div class='card-body'>
                    <h6 class='card-title mb-3'>Punches Per Hour (Today)</h6>
                    <canvas id='chartHour'></canvas>
                </div>
            </div>
        </div>
        <div class='col-lg-4'>
            <div class='card shadow-sm chart-card'>
                <div class='card-body'>
                    <h6 class='card-title mb-3'>Punches Per Device</h6>
                    <canvas id='chartDevice'></canvas>
                </div>
            </div>
        </div>
        <div class='col-lg-4'>
            <div class='card shadow-sm chart-card'>
                <div class='card-body'>
                    <h6 class='card-title mb-3'>Success vs Failed</h6>
                    <canvas id='chartStatus'></canvas>
                </div>
            </div>
        </div>
    </div>

    <!-- Row 4: Recent punches -->
    <div class='row g-3'>
        <div class='col-12'>
            <div class='card shadow-sm'>
                <div class='card-body'>
                    <h6 class='card-title mb-3'>Recent Punches</h6>
                    <div class='table-responsive'>
                        <table class='table table-sm table-striped align-middle mb-0'>
                            <thead>
                                <tr>
                                    <th>Time</th>
                                    <th>Employee</th>
                                    <th>Machine</th>
                                    <th>Direction</th>
                                    <th>HRONE Status</th>
                                </tr>
                            </thead>
                            <tbody id='recent-body'>
                                <tr><td colspan='5' class='text-center text-muted'>Loading...</td></tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js'></script>
<script>
    async function loadData() {
        try {
            const res = await fetch('/api/data');
            const data = await res.json();

            // Last biometric
            document.getElementById('bio-emp').textContent = data.lastBiometric.employee;
            document.getElementById('bio-mach').textContent = data.lastBiometric.machine;
            document.getElementById('bio-time').textContent = data.lastBiometric.time;

            // Last HRONE
            document.getElementById('hr-emp').textContent = data.lastHROne.employee;
            document.getElementById('hr-mach').textContent = data.lastHROne.machine;
            document.getElementById('hr-time').textContent = data.lastHROne.time;
            document.getElementById('hr-status').textContent = data.lastHROne.status;

            // Summary
            document.getElementById('sum-total').textContent = data.summary.totalPunches;
            document.getElementById('sum-uploaded').textContent = data.summary.uploaded;
            document.getElementById('sum-failed').textContent = data.summary.failed;
            document.getElementById('sum-rate').textContent = data.summary.successRate + '%';

            // Devices
            const devBody = document.getElementById('device-body');
            devBody.innerHTML = '';
            if (data.devices.length === 0) {
                devBody.innerHTML = "" +
                    '<tr><td colspan=""4"" class=""text-center text-muted"">No devices found</td></tr>';
            } else {
                data.devices.forEach(d => {
                    const tr = document.createElement('tr');
                    tr.innerHTML = `
                        <td>${d.name}</td>
                        <td>${d.direction}</td>
                        <td>${d.lastPing}</td>
                        <td>${d.status}</td>`;
                    devBody.appendChild(tr);
                });
            }

            // Recent punches
            const recBody = document.getElementById('recent-body');
            recBody.innerHTML = '';
            if (data.recent.length === 0) {
                recBody.innerHTML = "" +
                    '<tr><td colspan=""5"" class=""text-center text-muted"">No punches found</td></tr>';
            } else {
                data.recent.forEach(r => {
                    const tr = document.createElement('tr');
                    tr.innerHTML = `
                        <td>${r.time}</td>
                        <td>${r.employee}</td>
                        <td>${r.machine}</td>
                        <td>${r.direction}</td>
                        <td>${r.status}</td>`;
                    recBody.appendChild(tr);
                });
            }

            // Charts
            buildCharts(data.charts, data.summary);
        } catch (e) {
            console.error(e);
        }
    }

    function buildCharts(charts, summary) {
        const prefersDark = window.matchMedia &&
            window.matchMedia('(prefers-color-scheme: dark)').matches;

        const textColor = prefersDark ? '#e9ecef' : '#212529';
        const gridColor = prefersDark ? 'rgba(233,236,239,0.15)' : 'rgba(33,37,41,0.1)';

        // Hour chart
        const ctxHour = document.getElementById('chartHour');
        new Chart(ctxHour, {
            type: 'line',
            data: {
                labels: charts.byHour.labels,
                datasets: [{
                    label: 'Punches',
                    data: charts.byHour.values,
                    borderColor: '#0d6efd',
                    backgroundColor: 'rgba(13,110,253,0.2)',
                    tension: 0.3,
                    fill: true,
                    pointRadius: 3
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    x: {
                        ticks: { color: textColor },
                        grid: { color: gridColor }
                    },
                    y: {
                        ticks: { color: textColor },
                        grid: { color: gridColor },
                        beginAtZero: true
                    }
                }
            }
        });

        // Device chart
        const ctxDev = document.getElementById('chartDevice');
        new Chart(ctxDev, {
            type: 'bar',
            data: {
                labels: charts.byDevice.labels,
                datasets: [{
                    label: 'Punches',
                    data: charts.byDevice.values,
                    backgroundColor: '#198754'
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { display: false }
                },
                scales: {
                    x: {
                        ticks: { color: textColor },
                        grid: { color: gridColor }
                    },
                    y: {
                        ticks: { color: textColor },
                        grid: { color: gridColor },
                        beginAtZero: true
                    }
                }
            }
        });

        // Status chart
        const ctxStatus = document.getElementById('chartStatus');
        new Chart(ctxStatus, {
            type: 'doughnut',
            data: {
                labels: ['Success', 'Failed'],
                datasets: [{
                    data: [summary.uploaded, summary.failed],
                    backgroundColor: ['#198754', '#dc3545']
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        labels: { color: textColor }
                    }
                }
            }
        });
    }

    loadData();
    setInterval(loadData, 15000);
</script>

</body>
</html>";
        }

        // ---------- DATA QUERIES ----------

        private static (string employee, string machine, string time) GetLastBiometricPunch()
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                conn.Open();

                using var cmd = new SqlCommand(@"
                    SELECT TOP 1 dl.EmployeeCode, d.DeviceName, dl.LogDate
                    FROM eBioServerNew.dbo.DeviceLogs dl
                    INNER JOIN eBioServerNew.dbo.Devices d ON dl.DeviceId = d.DeviceId
                    ORDER BY dl.DeviceLogId DESC", conn);

                using var r = cmd.ExecuteReader();
                if (r.Read())
                {
                    return (
                        r.GetString(0),
                        r.GetString(1),
                        r.GetDateTime(2).ToString("dd/MM/yyyy HH:mm")
                    );
                }
            }
            catch { }

            return ("-", "-", "-");
        }

        private static (string employee, string machine, string time, string status) GetLastHROnePunch()
        {
            try
            {
                long lastId = 0;

                using (var conn = new SqlConnection(_connectionString))
                {
                    conn.Open();
                    using var cmdState = new SqlCommand(
                        "SELECT ISNULL(LastProcessedDeviceLogId, 0) FROM HROneSyncState",
                        conn);
                    var obj = cmdState.ExecuteScalar();
                    if (obj != null)
                        lastId = Convert.ToInt64(obj);
                }

                if (lastId <= 0)
                    return ("-", "-", "-", "No uploads yet");

                using var conn2 = new SqlConnection(_connectionString);
                conn2.Open();

                using var cmd = new SqlCommand(@"
                    SELECT TOP 1 dl.EmployeeCode, d.DeviceName, dl.LogDate
                    FROM eBioServerNew.dbo.DeviceLogs dl
                    INNER JOIN eBioServerNew.dbo.Devices d ON dl.DeviceId = d.DeviceId
                    WHERE dl.DeviceLogId = @id", conn2);

                cmd.Parameters.AddWithValue("@id", lastId);

                using var r = cmd.ExecuteReader();
                if (r.Read())
                {
                    return (
                        r.GetString(0),
                        r.GetString(1),
                        r.GetDateTime(2).ToString("dd/MM/yyyy HH:mm"),
                        "Success"
                    );
                }

                return ("-", "-", "-", "Not found");
            }
            catch
            {
                return ("-", "-", "-", "Error");
            }
        }

        private static (int totalPunches, int uploaded, int failed, double successRate) GetSyncSummary()
        {
            int total = 0;
            int uploaded = 0;

            try
            {
                long lastId = 0;

                using (var conn = new SqlConnection(_connectionString))
                {
                    conn.Open();

                    using (var cmdState = new SqlCommand(
                        "SELECT ISNULL(LastProcessedDeviceLogId, 0) FROM HROneSyncState",
                        conn))
                    {
                        var obj = cmdState.ExecuteScalar();
                        if (obj != null)
                            lastId = Convert.ToInt64(obj);
                    }

                    using (var cmdTotal = new SqlCommand(@"
                        SELECT COUNT(*) 
                        FROM eBioServerNew.dbo.DeviceLogs
                        WHERE CAST(LogDate AS date) = CAST(GETDATE() AS date)", conn))
                    {
                        total = Convert.ToInt32(cmdTotal.ExecuteScalar() ?? 0);
                    }

                    using (var cmdUploaded = new SqlCommand(@"
                        SELECT COUNT(*) 
                        FROM eBioServerNew.dbo.DeviceLogs
                        WHERE DeviceLogId <= @id
                          AND CAST(LogDate AS date) = CAST(GETDATE() AS date)", conn))
                    {
                        cmdUploaded.Parameters.AddWithValue("@id", lastId);
                        uploaded = Convert.ToInt32(cmdUploaded.ExecuteScalar() ?? 0);
                    }
                }
            }
            catch
            {
                // ignore
            }

            int failed = Math.Max(0, total - uploaded);
            double rate = total == 0 ? 0 : Math.Round((uploaded * 100.0) / total, 2);

            return (total, uploaded, failed, rate);
        }

        private static List<object> GetDeviceStatsRaw()
        {
            var list = new List<object>();

            try
            {
                using var conn = new SqlConnection(_connectionString);
                conn.Open();

                using var cmd = new SqlCommand(@"
                    SELECT DeviceName, DeviceDirection, LastPing
                    FROM eBioServerNew.dbo.Devices
                    ORDER BY DeviceId", conn);

                using var r = cmd.ExecuteReader();
                while (r.Read())
                {
                    string name = r.IsDBNull(0) ? "-" : r.GetString(0);
                    string dir = r.IsDBNull(1) ? "-" : r.GetString(1);
                    string ping = "-";
                    if (!r.IsDBNull(2))
                        ping = r.GetDateTime(2).ToString("dd/MM/yyyy HH:mm");

                    string status = ping == "-" ? "Unknown" : "Online";

                    list.Add(new
                    {
                        name,
                        direction = dir,
                        lastPing = ping,
                        status
                    });
                }
            }
            catch
            {
                // ignore
            }

            return list;
        }

        private static List<object> GetRecentPunchesRaw()
        {
            var list = new List<object>();

            try
            {
                long lastId = 0;

                using (var conn = new SqlConnection(_connectionString))
                {
                    conn.Open();
                    using var cmdState = new SqlCommand(
                        "SELECT ISNULL(LastProcessedDeviceLogId, 0) FROM HROneSyncState",
                        conn);
                    var obj = cmdState.ExecuteScalar();
                    if (obj != null)
                        lastId = Convert.ToInt64(obj);
                }

                using var conn2 = new SqlConnection(_connectionString);
                conn2.Open();

                using var cmd = new SqlCommand(@"
                    SELECT TOP 20 
                        dl.DeviceLogId,
                        dl.LogDate,
                        dl.EmployeeCode,
                        d.DeviceName,
                        dl.Direction
                    FROM eBioServerNew.dbo.DeviceLogs dl
                    INNER JOIN eBioServerNew.dbo.Devices d ON dl.DeviceId = d.DeviceId
                    ORDER BY dl.DeviceLogId DESC", conn2);

                using var r = cmd.ExecuteReader();
                while (r.Read())
                {
                    long id = r.GetInt64(0);
                    string time = r.GetDateTime(1).ToString("dd/MM/yyyy HH:mm");
                    string emp = r.GetString(2);
                    string mach = r.GetString(3);
                    string dir = r.IsDBNull(4) ? "-" : r.GetString(4);
                    string status = id <= lastId ? "Uploaded" : "Pending";

                    list.Add(new
                    {
                        time,
                        employee = emp,
                        machine = mach,
                        direction = dir,
                        status
                    });
                }
            }
            catch
            {
                // ignore
            }

            return list;
        }

        private static object GetChartData()
        {
            var byHourLabels = new List<string>();
            var byHourValues = new List<int>();

            var byDeviceLabels = new List<string>();
            var byDeviceValues = new List<int>();

            try
            {
                using var conn = new SqlConnection(_connectionString);
                conn.Open();

                // By hour (today)
                using (var cmdHour = new SqlCommand(@"
                    SELECT DATEPART(HOUR, LogDate) AS H, COUNT(*) AS C
                    FROM eBioServerNew.dbo.DeviceLogs
                    WHERE CAST(LogDate AS date) = CAST(GETDATE() AS date)
                    GROUP BY DATEPART(HOUR, LogDate)
                    ORDER BY H", conn))
                {
                    using var r = cmdHour.ExecuteReader();
                    while (r.Read())
                    {
                        int h = r.GetInt32(0);
                        int c = r.GetInt32(1);
                        byHourLabels.Add($"{h:00}:00");
                        byHourValues.Add(c);
                    }
                }

                // By device (last 24h)
                using (var cmdDev = new SqlCommand(@"
                    SELECT d.DeviceName, COUNT(*) AS C
                    FROM eBioServerNew.dbo.DeviceLogs dl
                    INNER JOIN eBioServerNew.dbo.Devices d ON dl.DeviceId = d.DeviceId
                    WHERE dl.LogDate >= DATEADD(HOUR, -24, GETDATE())
                    GROUP BY d.DeviceName
                    ORDER BY C DESC", conn))
                {
                    using var r = cmdDev.ExecuteReader();
                    while (r.Read())
                    {
                        string name = r.GetString(0);
                        int c = r.GetInt32(1);
                        byDeviceLabels.Add(name);
                        byDeviceValues.Add(c);
                    }
                }
            }
            catch
            {
                // ignore
            }

            return new
            {
                byHour = new { labels = byHourLabels, values = byHourValues },
                byDevice = new { labels = byDeviceLabels, values = byDeviceValues }
            };
        }
    }
}
