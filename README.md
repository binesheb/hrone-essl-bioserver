# HROne eSSL BioServer

Windows/.NET bridge that reads attendance data from an eSSL BioServer SQL database and pushes normalized biometric events to HROne.

## Architecture

- `HROneSync/HROneSyncService` — .NET Worker Service and dashboard
- `Data` — biometric database access
- `Services` — HROne API and synchronization logic
- `State` — local sync state
- `HROneSync/Publish` — deployment output

## Configuration

Production credentials are intentionally not stored in Git. Copy `HROneSync/HROneSyncService/appsettings.example.json` to `appsettings.json` in the deployment environment and provide the SQL connection string, HROne API key, and domain code through a secure local configuration process.

## Updates

See `UPDATE.md` for the controlled manual and automated deployment strategy.

## Security note

If this repository was cloned before the credential cleanup, rotate the exposed database password and HROne API key. Removing a secret from the current file does not remove it from existing Git history or previous clones.
