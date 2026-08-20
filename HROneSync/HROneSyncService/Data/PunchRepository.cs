using Microsoft.Data.SqlClient;

namespace HROneSyncService.Data
{
    public class PunchRecord
    {
        public int DeviceLogId { get; set; }
        public string EmployeeCode { get; set; } = "";
        public DateTime LogDate { get; set; }
        public string Direction { get; set; } = "";
        public string DeviceName { get; set; } = "";
    }

    public class PunchRepository
    {
        private readonly string _connectionString;

        public PunchRepository(string connectionString)
        {
            _connectionString = connectionString;
        }

        public PunchRecord? GetNextPunch(int lastProcessedId)
        {
            using var conn = new SqlConnection(_connectionString);
            conn.Open();

            var cmd = new SqlCommand(@"
                SELECT TOP 1 DeviceLogId, EmployeeCode, LogDate, Direction, DeviceName
                FROM dbo.DeviceLogs
                WHERE DeviceLogId > @LastId
                ORDER BY DeviceLogId ASC;
            ", conn);

            cmd.Parameters.AddWithValue("@LastId", lastProcessedId);

            using var reader = cmd.ExecuteReader();
            if (!reader.Read())
                return null;

            return new PunchRecord
            {
                DeviceLogId = reader.GetInt32(0),
                EmployeeCode = reader.GetString(1),
                LogDate = reader.GetDateTime(2),
                Direction = reader.GetString(3),
                DeviceName = reader.GetString(4)
            };
        }
    }
}
