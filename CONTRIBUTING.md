# Contributing

## Goal

Keep the connector reliable, understandable and easy to operate in production.

## Before changing code

1. Read the relevant code path completely.
2. Identify the business rule being changed.
3. Check the v1.0.0 baseline if behaviour is uncertain.
4. Avoid changing unrelated code.

## Pull/change discipline

Each change should answer:

- What problem does it solve?
- What existing behaviour can it affect?
- How was it tested?
- Does the README/manual need updating?

## SQL

- Always parameterize user-controlled values.
- Specify deterministic ordering.
- Prefer readable CTEs over compressed SQL.
- Keep business rules documented near complex queries.

## Comments

Comments should explain **why**, not merely repeat the code.

Good:

```csharp
// Serialize checkpoint writes so a manual resync cannot race the worker.
await CheckpointGate.WaitAsync();
```

Avoid:

```csharp
// Wait for the checkpoint gate.
await CheckpointGate.WaitAsync();
```

## Releases

Do not overwrite a release tag. Create a new version after a tested change.
