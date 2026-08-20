@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM ================================================================
REM HROne ESSL Biometric - Build / Publish / Restart
REM
REM IMPORTANT:
REM   The GitHub clone is the deployment source AND deployment folder.
REM   This script publishes into <repository>\Publish.
REM   The installed Windows service is reconfigured to run that binary.
REM
REM Expected layout:
REM   <repo>\HROneSync\HROneSyncService\HROneSyncService.csproj
REM   <repo>\Tools\rebuild-republish-restart.bat
REM   <repo>\Publish\HROneSyncService.exe
REM
REM Run this BAT file as Administrator.
REM ================================================================

set "SERVICE=HROneSyncService"
set "SCRIPT_DIR=%~dp0"
set "REPO_ROOT=%SCRIPT_DIR%.."
for %%I in ("%REPO_ROOT%") do set "REPO_ROOT=%%~fI"

REM The GitHub repository itself is the deployment target.
set "PUBLISH_DIR=%REPO_ROOT%\Publish"
set "PUBLISH_EXE=%PUBLISH_DIR%\HROneSyncService.exe"

set "PROJECT="
for /r "%REPO_ROOT%" %%F in (HROneSyncService.csproj) do (
    if not defined PROJECT set "PROJECT=%%~fF"
)

if not defined PROJECT (
    echo [ERROR] HROneSyncService.csproj was not found under:
    echo         %REPO_ROOT%
    exit /b 1
)

where dotnet >nul 2>&1
if errorlevel 1 (
    echo [ERROR] dotnet was not found in PATH.
    exit /b 2
)

net session >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Administrator privileges are required.
    echo         Right-click this BAT file and choose Run as administrator.
    exit /b 3
)

if not exist "%PUBLISH_DIR%" mkdir "%PUBLISH_DIR%"

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

echo [1/7] Stopping %SERVICE%...
sc.exe stop "%SERVICE%" >nul 2>&1

REM Wait up to 30 seconds for the service to stop.
set "STATE="
for /l %%N in (1,1,30) do (
    for /f "tokens=3" %%S in ('sc.exe query "%SERVICE%" ^| findstr /I "STATE"') do set "STATE=%%S"
    if /I "!STATE!"=="STOPPED" goto SERVICE_STOPPED
    timeout /t 1 /nobreak >nul
)

for /f "tokens=3" %%S in ('sc.exe query "%SERVICE%" ^| findstr /I "STATE"') do set "STATE=%%S"
if /I not "!STATE!"=="STOPPED" (
    echo [ERROR] Service did not stop within 30 seconds.
    exit /b 4
)

:SERVICE_STOPPED
echo       Service stopped.

echo.
echo [2/7] Restoring dependencies...
dotnet restore "%PROJECT%"
if errorlevel 1 (
    echo [ERROR] dotnet restore failed. Service remains stopped.
    exit /b 5
)

echo.
echo [3/7] Building Release configuration...
dotnet build "%PROJECT%" -c Release --no-restore
if errorlevel 1 (
    echo [ERROR] dotnet build failed. Service remains stopped.
    exit /b 6
)

echo.
echo [4/7] Publishing GitHub repository to its own Publish folder...
echo       %PUBLISH_DIR%
dotnet publish "%PROJECT%" -c Release --no-restore -o "%PUBLISH_DIR%"
if errorlevel 1 (
    echo [ERROR] dotnet publish failed. Service remains stopped.
    exit /b 7
)

if not exist "%PUBLISH_EXE%" (
    echo [ERROR] Published executable was not found:
    echo         %PUBLISH_EXE%
    exit /b 8
)

echo.
echo [5/7] Pointing Windows service to the GitHub clone...
sc.exe config "%SERVICE%" binPath= "\"%PUBLISH_EXE%\""
if errorlevel 1 (
    echo [ERROR] Could not update the Windows service binary path.
    exit /b 9
)

echo       Service binary:
echo       %PUBLISH_EXE%

echo.
echo [6/7] Starting %SERVICE%...
sc.exe start "%SERVICE%" >nul
if errorlevel 1 (
    echo [ERROR] Failed to start %SERVICE%.
    exit /b 10
)

REM Wait up to 30 seconds for RUNNING state.
set "STATE="
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
echo [7/7] Checking dashboard port 8009...
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
echo Repository: %REPO_ROOT%
echo Publish   : %PUBLISH_DIR%
echo Service   : %SERVICE%
echo Dashboard : http://localhost:8009
echo ================================================================
echo.
exit /b 0
