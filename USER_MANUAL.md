# User Manual

## Dashboard

Open:

`http://localhost:8009`

## Main cards

### Today

Total biometric punch records detected for the current day.

### Uploaded Today

Records marked as successfully uploaded to HROne.

### Ignored

Records intentionally excluded by connector rules.

### Pending

Synchronization backlog indicator based on the processing checkpoint.

### Pending Punch-Out

An operational attendance indicator. Its exact business rule must remain documented in the implementation and should not be changed without validating against ESSL attendance behaviour.

## Service controls

### Stop

Requests the connector to stop.

### Restart

Requests a controlled restart.

### Update

Starts the repository-controlled update process and reports progress through the dashboard.

## Troubleshooting

For a problem report, collect:

- Screenshot
- Time of issue
- Service status
- Last Processed DeviceLogId
- Latest DeviceLogId
- Error message
- Update log when relevant
