using Microsoft.Extensions.Configuration;

namespace HROneSyncService.State
{
    public static class ConnectionStringFactory
    {
        public static string Build(IConfiguration config)
        {
            string server = config["Database:Server"]!;
            string db = config["Database:Database"]!;
            string user = config["Database:User"]!;
            string password = config["Database:Password"]!;

            return $"Server={server};Database={db};User Id={user};Password={password};TrustServerCertificate=True;";
        }
    }
}
