@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM ================================================================
REM HROne ESSL Biometric - Build / Publish / Restart
REM
REM This script is location-aware. Keep it anywhere under the cloned
REM repository, preferably in the Tools folder.
REM
REM It will:
REM   1. Locate the repository root from this BAT file.
REM   2. Locate HROneSyncService.csproj under the repository.
REM   3. Read the installed Windows service binary path from SCM.
REM   4. Stop HROneSyncService.
REM   5. Build the .NET project.
REM   6. Publish directly to the installed service's directory.
REM   7. Start HROneSyncService.
REM   8. Verify the service state and dashboard port.
REM
REM Run this BAT file as Administrator.
REM ================================================================

set "SERVICE=HROneSyncService"
set "SCRIPT_DIR=%~dp0"
set "REPO_ROOT=%SCRIPT_DIR%.."
for %%I in ("%REPO_ROOT%") do set "REPO_ROOT=%%~fI"

set "PROJECT="
for /r "%REPO_ROOT%" %%F in (HROneSyncService.csproj) do (
    if not defined PROJECT set "PROJECT=%%~fF"
)

if not defined PROJECT (
    echo [ERROR] HROneSyncService.csproj was not found under:
    echo         %REPO_ROOT%
    exit /b 1
)

for %%I in ("%PROJECT%") do set "PROJECT_DIR=%%~dpI"

set "SERVICE_BIN="
for /f "tokens=2,*" %%A in ('sc.exe qc "%SERVICE%" ^| findstr /I "BINARY_PATH_NAME"') do (
    set "SERVICE_BIN=%%B"
)

if not defined SERVICE_BIN (
    echo [ERROR] Windows service "%SERVICE%" was not found.
    exit /b 2
)

REM Remove surrounding quotes and command-line arguments if present.
set "SERVICE_BIN=%SERVICE_BIN:"=%"
for /f "tokens=1" %%A in ("%SERVICE_BIN%") do set "SERVICE_EXE=%%A"

for %%I in ("%SERVICE_EXE%") do set "PUBLISH_DIR=%%~dpI"
if not defined PUBLISH_DIR (
    echo [ERROR] Could not determine the installed publish directory.
    exit /b 3
)

set "PUBLISH_DIR=%PUBLISH_DIR:~0,-1%"

where dotnet >nul 2>&1
if errorlevel 1 (
    echo [ERROR] dotnet was not found in PATH.
    exit /b 4
)

net session >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Administrator privileges are required.
    echo         Right-click this BAT file and choose Run as administrator.
    exit /b 5
)

cd /d "%REPO_ROOT%"

echo.
echo ================================================================
echo HROne ESSL Biometric deployment
 echo Repository : %REPO_ROOT%
echo Project    : %PROJECT%
echo Publish to : %PUBLISH_DIR%
echo Service    : %SERVICE%
echo ================================================================
echo.

echo [1/6] Stopping %SERVICE%...
sc.exe stop "%SERVICE%" >nul 2>&1

REM Wait up to 30 seconds for the service to stop.
for /l %%N in (1,1,30) do (
    for /f "tokens=3" %%S in ('sc.exe query "%SERVICE%" ^| findstr /I "STATE"') do set "STATE=%%S"
    if /I "!STATE!"=="STOPPED" goto SERVICE_STOPPED
    timeout /t 1 /nobreak >nul
)

for /f "tokens=3" %%S in ('sc.exe query "%SERVICE%" ^| findstr /I "STATE"') do set "STATE=%%S"
if /I not "!STATE!"=="STOPPED" (
    echo [ERROR] Service did not stop within 30 seconds.
    exit /b 6
)

:SERVICE_STOPPED
echo       Service stopped.

echo.
echo [2/6] Restoring/building dependencies...
dotnet restore "%PROJECT%"
if errorlevel 1 (
    echo [ERROR] dotnet restore failed.
    exit /b 7
)

echo.
echo [3/6] Building Release configuration...
dotnet build "%PROJECT%" -c Release --no-restore
if errorlevel 1 (
    echo [ERROR] dotnet build failed. Service has NOT been restarted.
    exit /b 8
)

echo.
echo [4/6] Publishing to installed service directory...
dotnet publish "%PROJECT%" -c Release --no-restore -o "%PUBLISH_DIR%"
if errorlevel 1 (
    echo [ERROR] dotnet publish failed. Service has NOT been restarted.
    exit /b 9
)

echo.
echo [5/6] Starting %SERVICE%...
sc.exe start "%SERVICE%" >nul
if errorlevel 1 (
    echo [ERROR] Failed to start %SERVICE%.
    exit /b 10
)

REM Wait up to 30 seconds for RUNNING state.
for /l %%N in (1,1,30) do (
    for /f "tokens=3" %%S in ('sc.exe query "%SERVICE%" ^| findstr /I "STATE"') do set "STATE=%%S"
    if /I "!STATE!"=="RUNNING" goto SERVICE_RUNNING
    timeout /t 1 /nobreak >nul
)

for /f "tokens=3" %%S in ('sc.exe query "%SERVICE%" ^| findstr /I "STATE"') do set "STATE=%%S"
if /I not "!STATE!"=="RUNNING" (
    echo [ERROR] Service did not reach RUNNING state within 30 seconds.
    exit /b 11
)

:SERVICE_RUNNING
echo       Service is RUNNING.

echo.
echo [6/6] Checking dashboard port 8009...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=Get-NetTCPConnection -LocalPort 8009 -State Listen -ErrorAction SilentlyContinue; if($c){exit 0}else{exit 1}"
if errorlevel 1 (
    echo [WARN] Port 8009 is not listening yet.
    echo       Check Windows Event Viewer if the dashboard does not load.
) else (
    echo       Dashboard is listening on port 8009.
)

echo.
echo ================================================================
echo Deployment completed successfully.
echo Dashboard: http://localhost:8009
 echo Publish : %PUBLISH_DIR%
echo Service  : %SERVICE%
echo ================================================================
echo.
exit /b 0
