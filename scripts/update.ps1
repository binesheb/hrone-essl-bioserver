[CmdletBinding()]
param(
    [string]$Project = "HROneSync/HROneSyncService/HROneSyncService.csproj"
)

$ErrorActionPreference = "Stop"
$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot ".."))
Set-Location $repoRoot

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "Git is required for updates."
}

$branch = (git rev-parse --abbrev-ref HEAD).Trim()
if ($branch -ne "main") {
    throw "Automatic updates are allowed only while on the main branch. Current branch: $branch"
}

if ((git status --porcelain).Trim()) {
    throw "Refusing to update because the working tree contains local changes."
}

$oldRevision = (git rev-parse HEAD).Trim()

git fetch origin main --prune
$relation = (git rev-list --left-right --count HEAD...origin/main).Trim().Split()
$behind = [int]$relation[1]
$ahead = [int]$relation[0]

if ($ahead -ne 0) {
    throw "Refusing to update because local main has commits not present on origin/main."
}

if ($behind -eq 0) {
    Write-Host "Already up to date with origin/main."
    exit 0
}

try {
    git merge --ff-only origin/main
    & (Join-Path $PSScriptRoot "bootstrap.ps1") -Project $Project
    Write-Host "Updated from origin/main and validated successfully."
}
catch {
    Write-Warning "Validation failed; restoring revision $oldRevision."
    git reset --hard $oldRevision
    throw
}
