# Updating HROne eSSL BioServer

This service runs against a local biometric database and a remote HROne endpoint, so updates should be controlled and reversible.

## Dependency bootstrap

From the repository root on Windows:

```powershell
./scripts/bootstrap.ps1
```

The helper verifies that the .NET SDK is available, restores the NuGet packages declared by the project, and performs a Release build before deployment. It does not create or overwrite production credentials.

## Manual update

1. Stop the Windows service.
2. Back up the deployed application folder and its local configuration.
3. Update the repository with `git pull --ff-only origin main`.
4. Run `./scripts/update.ps1` to restore declared dependencies and validate the updated source. If the repository was already updated manually, the script exits after confirming `origin/main` is current.
5. Publish the service with the installed .NET SDK.
6. Restore the deployment-specific `appsettings.json` values from your secure local copy.
7. Start the service and verify the dashboard and sync logs.

Do not overwrite production credentials with repository defaults.

## Automatic update

Use `./scripts/update.ps1` from a managed scheduler or deployment job. The updater:

- fetches **`origin/main` only**;
- refuses feature/development branches, local changes, and diverged local history;
- applies only a fast-forward update;
- restores declared NuGet dependencies and performs a Release build;
- resets to the previous Git revision if validation fails.

The updater validates source and dependencies but deliberately does not stop or restart the production Windows service. Service replacement should remain a managed deployment step with backup, publish, health checks, and rollback because this application bridges production attendance data.

GitHub `main` is the sole automatic-update source. Tags/releases remain suitable for explicit deployment snapshots and rollback, not for a separate automatic-update channel.
