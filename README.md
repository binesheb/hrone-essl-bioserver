# HROne–eSSL BioServer Connector

> **Windows service and operational dashboard for synchronizing biometric punch data from eSSL BioServer to HROne.**

## Project status

- **Stable baseline:** v1.0.0
- **Production branch:** `main`
- **Deployment model:** Windows Service + local dashboard
- **Default dashboard:** `http://localhost:8009`

## What this project does

The connector reads biometric attendance records from the eSSL BioServer SQL database and processes them for HROne synchronization.

### Core capabilities

- Read biometric `DeviceLogs`
- Maintain a synchronization checkpoint using `DeviceLogId`
- Track punch processing states:
  - **Pending**
  - **Ignored**
  - **Uploaded**
- Provide a local operations dashboard
- Display recent biometric activity
- Control and restart the Windows service
- Support controlled GitHub-based updates
- Provide checkpoint and date-based resynchronization tools

## Architecture

```text
ESSL Biometric Devices
        ↓
eBioServer SQL Database
        ↓
HROneSyncService
   ├── Sync Worker
   ├── State Tracking
   ├── HROne API Integration
   └── Local Dashboard :8009
        ↓
       HROne
```

## Repository guide

| Area | Purpose |
|---|---|
| `HROneSync/HROneSyncService` | Main .NET Windows service and dashboard |
| `Dashboard.cs` | Local HTTP dashboard and operational API |
| `Program.cs` | Application startup and dependency configuration |
| `Tools` | Deployment, update and operational scripts |
| `UPDATE.md` | Controlled update/deployment procedure |
| `appsettings.example.json` | Safe configuration template |

## Important concepts

### DeviceLogId checkpoint

The service uses `DeviceLogId` as its synchronization position.

```text
Last Processed DeviceLogId → Latest DeviceLogId
```

The difference is a **checkpoint backlog indicator**. It should not automatically be described as an exact row count unless the database guarantees contiguous IDs.

### Punch status

| Status | Meaning |
|---|---|
| Pending | Not yet fully processed |
| Ignored | Intentionally excluded from HROne synchronization |
| Uploaded | Successfully processed for HROne |

## Configuration

**Never commit production credentials.**

Copy the example configuration and provide production values through a secure deployment process:

```text
appsettings.example.json
        ↓
appsettings.json
```

Typical sensitive values include:

- SQL connection strings
- HROne API keys
- Authentication credentials
- Internal service URLs

## Development rules

1. **Keep `main` deployable.**
2. Implement and test **one feature at a time**.
3. Do not mix unrelated refactoring with functional changes.
4. Preserve the stable release tag before risky changes.
5. Prefer parameterized SQL.
6. Use deterministic ordering for punch processing:
   `LogDate`, then `DeviceLogId`.
7. Do not silently change attendance business rules.
8. Add comments explaining **why** non-obvious logic exists.
9. Never commit secrets.
10. Update documentation when operational behaviour changes.

## Code style

- Prefer small methods with one responsibility.
- Avoid long one-line methods.
- Use descriptive names.
- Add XML comments to public operational entry points where useful.
- Explain safety-sensitive code such as checkpoint changes, service restarts and update execution.
- Keep SQL readable and parameterized.

## Testing checklist

Before production deployment:

- [ ] Build succeeds
- [ ] Service starts
- [ ] Dashboard opens
- [ ] Database health check succeeds
- [ ] Latest DeviceLogId is correct
- [ ] Checkpoint changes are safe
- [ ] Recent punch status is correct
- [ ] Update workflow reports progress
- [ ] Restart works
- [ ] No secrets were committed

## Operations

See:

- `USER_MANUAL.md` for operators
- `CONTRIBUTING.md` for development rules
- `ARCHITECTURE.md` for system design
- `UPDATE.md` for deployment/update procedures

## Release policy

Use semantic versioning:

- `v1.0.1` — bug fix
- `v1.1.0` — tested feature
- `v2.0.0` — major architectural change

The current stable baseline is **v1.0.0**.
