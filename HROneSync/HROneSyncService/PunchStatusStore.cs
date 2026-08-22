using Microsoft.Data.SqlClient;

namespace HROneSyncService;

public sealed class PunchStatusStore
{
    private readonly string _connectionString;

    public PunchStatusStore(string connectionString)
    {
        _connectionString = connectionString;
        EnsureSchema();
    }

    private void EnsureSchema()
    {
        using var c = new SqlConnection(_connectionString);
        c.Open();
        using var cmd = new SqlCommand(@"
IF OBJECT_ID('dbo.HROnePunchStatus','U') IS NULL
BEGIN
    CREATE TABLE dbo.HROnePunchStatus
    (
        DeviceLogId BIGINT NOT NULL PRIMARY KEY,
        Status VARCHAR(16) NOT NULL,
        UpdatedAt DATETIME2 NOT NULL CONSTRAINT DF_HROnePunchStatus_UpdatedAt DEFAULT(GETDATE())
    );
END;

INSERT INTO dbo.HROnePunchStatus(DeviceLogId, Status)
SELECT dl.DeviceLogId,
       CASE WHEN ISNULL(dc.SyncEnabled, 1) = 0 THEN 'Ignored' ELSE 'Uploaded' END
FROM eBioServerNew.dbo.DeviceLogs dl
LEFT JOIN dbo.HROneDeviceSyncControl dc ON dc.DeviceId = dl.DeviceId
LEFT JOIN dbo.HROnePunchStatus ps ON ps.DeviceLogId = dl.DeviceLogId
WHERE ps.DeviceLogId IS NULL
  AND dl.DeviceLogId <= ISNULL((SELECT MAX(LastProcessedDeviceLogId) FROM dbo.HROneSyncState), 0);", c);
        cmd.CommandTimeout = 30;
        cmd.ExecuteNonQuery();
    }

    public async Task SetStatus(long deviceLogId, string status, CancellationToken token)
    {
        await using var c = new SqlConnection(_connectionString);
        await c.OpenAsync(token);
        await using var cmd = new SqlCommand(@"
IF EXISTS (SELECT 1 FROM dbo.HROnePunchStatus WHERE DeviceLogId=@DeviceLogId)
    UPDATE dbo.HROnePunchStatus SET Status=@Status, UpdatedAt=GETDATE() WHERE DeviceLogId=@DeviceLogId;
ELSE
    INSERT INTO dbo.HROnePunchStatus(DeviceLogId, Status, UpdatedAt) VALUES(@DeviceLogId,@Status,GETDATE());", c);
        cmd.Parameters.AddWithValue("@DeviceLogId", deviceLogId);
        cmd.Parameters.AddWithValue("@Status", status);
        await cmd.ExecuteNonQueryAsync(token);
    }
}
