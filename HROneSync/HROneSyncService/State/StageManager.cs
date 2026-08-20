using Microsoft.Data.SqlClient;

namespace HROneSyncService.State
{
    public class StateManager
    {
        private readonly string _connectionString;
        private readonly string _stateFilePath;

        public StateManager(string connectionString, string stateFilePath)
        {
            _connectionString = connectionString;
            _stateFilePath = stateFilePath;
        }

        public int GetLastProcessedId()
        {
            int id = 0;

            using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT TOP 1 LastProcessedDeviceLogId FROM dbo.HROneSyncState", conn);
                var result = cmd.ExecuteScalar();
                if (result != null)
                    id = Convert.ToInt32(result);
            }

            if (File.Exists(_stateFilePath))
            {
                var text = File.ReadAllText(_stateFilePath).Trim();
                if (int.TryParse(text, out int fileId))
                {
                    if (fileId > id)
                        id = fileId;
                }
            }

            return id;
        }

        public void UpdateLastProcessedId(int newId)
        {
            using (var conn = new SqlConnection(_connectionString))
            {
                conn.Open();
                var cmd = new SqlCommand(@"
                    UPDATE dbo.HROneSyncState
                    SET LastProcessedDeviceLogId = @Id,
                        LastUpdated = GETDATE();
                ", conn);

                cmd.Parameters.AddWithValue("@Id", newId);
                cmd.ExecuteNonQuery();
            }

            File.WriteAllText(_stateFilePath, newId.ToString());
        }
    }
}
