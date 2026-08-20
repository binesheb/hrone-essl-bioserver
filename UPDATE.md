# Updating HROne eSSL BioServer

This service runs against a local biometric database and a remote HROne endpoint, so updates should be controlled and reversible.

## Manual update

1. Stop the Windows service.
2. Back up the deployed application folder and its local configuration.
3. Pull the desired Git tag or commit from GitHub.
4. Publish the service with the installed .NET SDK.
5. Restore the deployment-specific `appsettings.json` values from your secure local copy.
6. Start the service and verify the dashboard and sync logs.

Do not overwrite production credentials with repository defaults.

## Automatic update

Automatic in-place replacement is not enabled by default. For production, use a managed deployment job that downloads a pinned GitHub release, validates the package, stops the service, backs up the current version, deploys the new version, and rolls back if the health check fails. This keeps GitHub as the source of truth without allowing an unattended process to replace a running attendance bridge from an arbitrary branch.
