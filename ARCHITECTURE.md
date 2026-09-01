# Architecture

## Components

### Windows Host

`Program.cs` creates the .NET Generic Host, configures Windows Service integration, logging and application services.

### Worker

The Worker owns the background synchronization lifecycle. It should remain responsible for moving punch data, not for HTTP presentation logic.

### DashboardServer

`DashboardServer` hosts the local operational dashboard.

It is responsible for:

- HTTP routing
- Dashboard data queries
- Health reporting
- Checkpoint tools
- Controlled service actions
- Update progress reporting

## Data flow

```text
DeviceLogs
   ↓
Checkpoint comparison
   ↓
Synchronization worker
   ↓
HROnePunchStatus
   ├── Uploaded
   ├── Ignored
   └── Pending
```

## Safety boundaries

### Checkpoint changes

Changing `LastProcessedDeviceLogId` changes where synchronization resumes. This is operationally sensitive and must remain serialized through `CheckpointGate`.

### Resync

Resync should:

1. Validate input
2. Persist the checkpoint transactionally
3. Release database locks
4. Request a graceful application restart

### Updates

The dashboard may start an external update script. The updater owns source retrieval, build/publish and service restart.

The running service should never overwrite its own executable directly.

## Performance rules

Use range predicates for indexed datetime columns:

```sql
LogDate >= @Start
AND LogDate < @End
```

Avoid wrapping indexed columns in functions where possible:

```sql
CAST(LogDate AS date)
```

unless database size and indexing have been evaluated.
