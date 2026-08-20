using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Configuration;
using Microsoft.Data.SqlClient;
using System.Net.Http;
using System.Text;
using System.Text.Json;

namespace HROneSyncService
{
    public class Worker : BackgroundService
    {
        private readonly ILogger<Worker> _logger;
        private readonly IConfiguration _config;
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly IHostApplicationLifetime _applicationLifetime;

        private readonly string _connectionString;
        private readonly string _apiUrl;
        private readonly string _apiKey;
        private readonly string _domainCode;
        private readonly int _pollSeconds;

        public Worker(
            ILogger<Worker> logger,
            IConfiguration config,
            IHttpClientFactory httpClientFactory,
            IHostApplicationLifetime applicationLifetime)
        {
            _logger = logger;
            _config = config;
            _httpClientFactory = httpClientFactory;
            _applicationLifetime = applicationLifetime;

            _connectionString = _config.GetConnectionString("DefaultConnection")
                ?? throw new Exception("Missing DefaultConnection");

            _apiUrl = _config["HROne:ApiUrl"]
                ?? throw new Exception("Missing HROne:ApiUrl");

            _apiKey = _config["HROne:ApiKey"]
                ?? throw new Exception("Missing HROne:ApiKey");

            _domainCode = _config["HROne:DomainCode"]
                ?? throw new Exception("Missing HROne:DomainCode");

            _pollSeconds = _config.GetValue<int>("Sync:PollIntervalSeconds", 5);
        }

        protected override async Task ExecuteAsync(CancellationToken stoppingToken)
        {
            _logger.LogInformation("Worker started");
            DashboardServer.Start(_connectionString, 8009, () => _applicationLifetime.StopApplication());

            while (!stoppingToken.IsCancellationRequested)
            {
                try
                {
                    long lastId = await GetLastProcessedId(stoppingToken);
                    var logs = await GetNewLogs(lastId, stoppingToken);

                    if (logs.Count == 0)
                        _logger.LogInformation("No new logs after {LastId}", lastId);
                    else
                    {
                        _logger.LogInformation("Processing {Count} logs starting from {LastId}", logs.Count, lastId);
                        foreach (var log in logs)
                        {
                            bool ok = await PushToHROne(log, stoppingToken);
                            if (ok) await UpdateLastProcessedId(log.DeviceLogId, stoppingToken);
                        }
                    }
                }
                catch (Exception ex)
                {
                    _logger.LogError(ex, "Fatal error in worker loop");
                }

                await Task.Delay(TimeSpan.FromSeconds(_pollSeconds), stoppingToken);
            }

            _logger.LogInformation("Worker stopping");
        }

        private async Task<long> GetLastProcessedId(CancellationToken token)
        {
            using var conn = new SqlConnection(_connectionString);
            await conn.OpenAsync(token);
            using var cmd = new SqlCommand("SELECT ISNULL(LastProcessedDeviceLogId, 0) FROM HROneSyncState", conn);
            return Convert.ToInt64(await cmd.ExecuteScalarAsync(token));
        }

        private async Task UpdateLastProcessedId(long id, CancellationToken token)
        {
            using var conn = new SqlConnection(_connectionString);
            await conn.OpenAsync(token);
            using var cmd = new SqlCommand("UPDATE HROneSyncState SET LastProcessedDeviceLogId = @id", conn);
            cmd.Parameters.AddWithValue("@id", id);
            await cmd.ExecuteNonQueryAsync(token);
            _logger.LogInformation("Updated LastProcessedDeviceLogId to {Id}", id);
        }

        private async Task<List<DeviceLogDto>> GetNewLogs(long lastId, CancellationToken token)
        {
            var list = new List<DeviceLogDto>();
            using var conn = new SqlConnection(_connectionString);
            await conn.OpenAsync(token);
            using var cmd = new SqlCommand(@"
                SELECT DeviceLogId, DeviceId, EmployeeCode, LogDate, Direction
                FROM eBioServerNew.dbo.DeviceLogs
                WHERE DeviceLogId > @id
                ORDER BY DeviceLogId ASC", conn);
            cmd.Parameters.AddWithValue("@id", lastId);
            using var reader = await cmd.ExecuteReaderAsync(token);
            while (await reader.ReadAsync(token))
            {
                list.Add(new DeviceLogDto
                {
                    DeviceLogId = reader.GetInt64(0),
                    DeviceId = reader.GetInt32(1),
                    EmployeeCode = reader.GetString(2),
                    LogDate = reader.GetDateTime(3),
                    Direction = reader.IsDBNull(4) ? null : reader.GetString(4)
                });
            }
            return list;
        }

        private string MapMachine(int deviceId, string? direction)
        {
            try
            {
                using var conn = new SqlConnection(_connectionString);
                conn.Open();
                using var cmd = new SqlCommand("SELECT DeviceName FROM eBioServerNew.dbo.Devices WHERE DeviceId = @id", conn);
                cmd.Parameters.AddWithValue("@id", deviceId);
                var result = cmd.ExecuteScalar();
                return result?.ToString() ?? "UNKNOWN";
            }
            catch { return "UNKNOWN"; }
        }

        private async Task<bool> PushToHROne(DeviceLogDto log, CancellationToken token)
        {
            try
            {
                var client = _httpClientFactory.CreateClient("HROneClient");
                client.DefaultRequestHeaders.Clear();
                client.DefaultRequestHeaders.Add("API-Key", _apiKey);
                client.DefaultRequestHeaders.Add("domainCode", _domainCode);

                var payload = new
                {
                    dataTable = new[]
                    {
                        new
                        {
                            FK_EMPLOYEE_CODE = log.EmployeeCode,
                            FK_BIOMETRIC_ID = log.EmployeeCode,
                            PUNCH_DATETIME = log.LogDate.ToString("yyyy-MM-dd HH:mm"),
                            MACHINE_NO = MapMachine(log.DeviceId, log.Direction),
                            IPADDRESS = ""
                        }
                    }
                };

                string json = JsonSerializer.Serialize(payload);
                var content = new StringContent(json, Encoding.UTF8, "application/json");
                _logger.LogInformation("Pushing {Id} to HROne: {Json}", log.DeviceLogId, json);
                var response = await client.PostAsync(_apiUrl, content, token);
                string result = await response.Content.ReadAsStringAsync(token);
                _logger.LogInformation("HROne Response for {Id}: {Result}", log.DeviceLogId, result);

                if (!response.IsSuccessStatusCode)
                {
                    _logger.LogWarning("HROne returned {Status} for {Id}", (int)response.StatusCode, log.DeviceLogId);
                    return false;
                }
                return true;
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error pushing log {Id} to HROne", log.DeviceLogId);
                return false;
            }
        }
    }

    public class DeviceLogDto
    {
        public long DeviceLogId { get; set; }
        public int DeviceId { get; set; }
        public string EmployeeCode { get; set; } = "";
        public DateTime LogDate { get; set; }
        public string? Direction { get; set; }
    }
}
