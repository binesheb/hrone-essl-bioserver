# Updating HROne eSSL BioServer

This service runs against a local biometric database and a remote HROne endpoint, so updates should be controlled and reversible.

## Dependency bootstrap

From the repository root on Windows:

```powershell
./scripts/bootstrap.ps1
```

The helper verifies that the .NET SDK is available, restores the NuGet packages declared by the project, and performs a Release build before deployment. It does not create or overwrite production credentials.

## Manual update

1. Run `./scripts/bootstrap.ps1` to restore and validate the source.
2. Stop the Windows service.
3. Back up the deployed application folder and its local configuration.
4. Pull the desired Git tag or commit from GitHub.
5. Publish the service with the installed .NET SDK.
6. Restore the deployment-specific `appsettings.json` values from your secure local copy.
7. Start the service and verify the dashboard and sync logs.

Do not overwrite production credentials with repository defaults.

## Automatic update

Automatic in-place replacement is not enabled by default. For production, use a managed deployment job that downloads a pinned GitHub release, validates the package, stops the service, backs up the current version, deploys the new version, and rolls back if the health check fails. This keeps GitHub as the source of truth without allowing an unattended process to replace a running attendance bridge from an arbitrary branch.
