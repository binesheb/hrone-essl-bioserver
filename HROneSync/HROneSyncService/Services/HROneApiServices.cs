using System.Net.Http;
using System.Text;
using System.Text.Json;
using Microsoft.Extensions.Logging;

namespace HROneSyncService.Services
{
    public class HROneApiService
    {
        private readonly HttpClient _httpClient;
        private readonly string _apiUrl;
        private readonly string _apiKey;
        private readonly ILogger<HROneApiService> _logger;

        public HROneApiService(HttpClient httpClient, string apiUrl, string apiKey, ILogger<HROneApiService> logger)
        {
            _httpClient = httpClient;
            _apiUrl = apiUrl;
            _apiKey = apiKey;
            _logger = logger;
        }

        public async Task<(bool Success, string Response)> PushPunchAsync(
            string employeeCode,
            DateTime punchTime,
            string machineName)
        {
            var payload = new
            {
                FK_EMPLOYEE_CODE = employeeCode,
                FK_BIOMETRIC_ID = employeeCode,
                PUNCH_DATETIME = punchTime.ToString("yyyy-MM-dd HH:mm"),
                MACHINE_NO = machineName,
                IPADDRESS = ""
            };

            var json = JsonSerializer.Serialize(payload);
            var content = new StringContent(json, Encoding.UTF8, "application/json");

            _httpClient.DefaultRequestHeaders.Clear();
            _httpClient.DefaultRequestHeaders.Add("ApiKey", _apiKey);

            try
            {
                var response = await _httpClient.PostAsync(_apiUrl, content);
                var responseText = await response.Content.ReadAsStringAsync();

                if (response.IsSuccessStatusCode)
                {
                    _logger.LogInformation("HROne SUCCESS: {0}", responseText);
                    return (true, responseText);
                }
                else
                {
                    _logger.LogWarning("HROne FAILED: {0}", responseText);
                    return (false, responseText);
                }
            }
            catch (Exception ex)
            {
                _logger.LogError("HROne ERROR: {0}", ex.Message);
                return (false, ex.Message);
            }
        }
    }
}
