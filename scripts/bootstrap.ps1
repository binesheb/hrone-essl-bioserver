[CmdletBinding()]
param(
    [string]$Project = "HROneSync/HROneSyncService/HROneSyncService.csproj"
)

$ErrorActionPreference = "Stop"

if (-not (Get-Command dotnet -ErrorAction SilentlyContinue)) {
    throw "The .NET SDK is required. Install a supported .NET 10 SDK before running this script."
}

if (-not (Test-Path $Project)) {
    throw "Project file not found: $Project"
}

Write-Host "Restoring declared NuGet dependencies..."
dotnet restore $Project --locked-mode:$false

Write-Host "Building the service without publishing secrets..."
dotnet build $Project --configuration Release --no-restore

Write-Host "Bootstrap validation completed successfully."
