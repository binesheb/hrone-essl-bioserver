@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM ================================================================
REM HROne ESSL Biometric - LOCATION-AWARE BUILD / DEPLOY / RESTART
REM
REM IMPORTANT:
REM   GitHub/source and production are TWO SEPARATE INSTANCES.
REM   This script NEVER copies or modifies the other instance.
REM
REM GitHub instance:
REM   C:\hrone-essl-bioserver\HROneSync\HROneSyncService
REM   -> publishes to C:\hrone-essl-bioserver\Publish
REM
REM Production instance:
REM   C:\HROneSync\HROneSyncService (if source exists there)
REM   -> publishes to C:\HROneSync\Publish
REM
REM The INSTANCE is determined from the location of this BAT file.
REM Therefore run the BAT from the Tools directory belonging to the
REM instance you intend to build/deploy.
REM
REM Every deployment:
REM   1. Resolves the instance from this BAT's location.
REM   2. Resolves that instance's source project.
REM   3. Resolves that instance's Publish directory.
REM   4. Stops HROneSyncService and waits for STOPPED.
REM   5. Restores, cleans, builds and publishes that instance only.
REM   6. Updates the Windows service binPath to that instance's EXE.
REM   7. Starts the service and verifies RUNNING.
REM   8. Verifies dashboard port 8009.
REM
REM Run as Administrator.
REM ================================================================

set "SERVICE=HROneSyncService"
set "SCRIPT_DIR=%~dp0"
for %%I in ("%SCRIPT_DIR%..") do set "INSTANCE_ROOT=%%~fI"

REM Never guess another instance. The tool must belong to the instance.
set "PROJECT=%INSTANCE_ROOT%\HROneSync\HROneSyncService\HROneSyncService.csproj"
set "PUBLISH_DIR=%INSTANCE_ROOT%\Publish"
set "PUBLISH_EXE=%PUBLISH_DIR%\HROneSyncService.exe"

where dotnet >nul 2>&1
if errorlevel 1 (
    echo [ERROR] dotnet was not found in PATH.
    exit /b 1
)

net session >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Administrator privileges are required.
    echo         Run this BAT as Administrator.
    exit /b 2
)

if not exist "%PROJECT%" (
    echo [ERROR] This tool does not belong to a valid HROneSync instance.
    echo [ERROR] Expected project:
    echo         %PROJECT%
    echo.
    echo The tool must remain inside the instance's Tools folder.
    exit /b 3
)

if not exist "%PUBLISH_DIR%" mkdir "%PUBLISH_DIR%"
cd /d "%INSTANCE_ROOT%"

set "SERVICE_EXISTS=0"
sc.exe query "%SERVICE%" >nul 2>&1
if not errorlevel 1 set "SERVICE_EXISTS=1"

echo.
echo ================================================================
echo LOCATION-AWARE HROne ESSL DEPLOYMENT
echo ================================================================
echo Instance   : %INSTANCE_ROOT%
echo Source     : %PROJECT%
echo Publish    : %PUBLISH_DIR%
echo Service    : %SERVICE%
echo ================================================================
echo.

if "%SERVICE_EXISTS%"=="1" (
    echo [1/9] Stopping %SERVICE%...
    sc.exe stop "%SERVICE%" >nul 2>&1
    set "STATE="
    for /l %%N in (1,1,30) do (
        set "STATE="
        for /f "tokens=3" %%S in ('sc.exe query "%SERVICE%" ^| findstr /I "STATE"') do set "STATE=%%S"
        if /I "!STATE!"=="STOPPED" goto SERVICE_STOPPED
        timeout /t 1 /nobreak >nul
    )
    echo [ERROR] %SERVICE% did not reach STOPPED state.
    echo         Deployment aborted. The running service was NOT overwritten.
    exit /b 4
) else (
    echo [1/9] Service is not installed yet. It will be created after publish.
)

:SERVICE_STOPPED
echo       Service stopped.

echo.
echo [2/9] Restoring dependencies...
dotnet restore "%PROJECT%"
if errorlevel 1 (
    echo [ERROR] Restore failed. Service remains stopped.
    exit /b 5
)

echo.
echo [3/9] Cleaning Release build...
dotnet clean "%PROJECT%" -c Release --no-restore
if errorlevel 1 (
    echo [ERROR] Clean failed. Service remains stopped.
    exit /b 6
)

echo.
echo [4/9] Building Release...
dotnet build "%PROJECT%" -c Release --no-restore
if errorlevel 1 (
    echo [ERROR] Build failed. Service remains stopped.
    exit /b 7
)

echo.
echo [5/9] Publishing THIS INSTANCE...
echo       %PUBLISH_DIR%
dotnet publish "%PROJECT%" -c Release --no-restore -o "%PUBLISH_DIR%"
if errorlevel 1 (
    echo [ERROR] Publish failed. Service remains stopped.
    exit /b 8
)

if not exist "%PUBLISH_EXE%" (
    echo [ERROR] Published executable was not found:
    echo         %PUBLISH_EXE%
    exit /b 9
)

echo.
echo [6/9] Configuring Windows service for THIS INSTANCE...
if "%SERVICE_EXISTS%"=="0" (
    sc.exe create "%SERVICE%" binPath= "\"%PUBLISH_EXE%\"" start= auto DisplayName= "HROne ESSL Biometric Sync Service"
    if errorlevel 1 (
        echo [ERROR] Could not create Windows service.
        exit /b 10
    )
    sc.exe description "%SERVICE%" "ESSL/eBioServer to HROne biometric attendance synchronization service."
) else (
    sc.exe config "%SERVICE%" binPath= "\"%PUBLISH_EXE%\"" start= auto
    if errorlevel 1 (
        echo [ERROR] Could not update Windows service binPath.
        exit /b 10
    )
)

REM Windows recovery: restart only after an unexpected service failure.
sc.exe failure "%SERVICE%" reset= 86400 actions= restart/60000/restart/60000/restart/60000 >nul 2>&1

echo.
echo [7/9] Verifying Windows service path...
set "BINPATH="
for /f "tokens=2,*" %%A in ('sc.exe qc "%SERVICE%" ^| findstr /I "BINARY_PATH_NAME"') do set "BINPATH=%%B"
echo       SCM: !BINPATH!
echo !BINPATH! | findstr /I /C:"%PUBLISH_EXE%" >nul
if errorlevel 1 (
    echo [ERROR] Windows service is NOT pointing to this instance.
    echo         Expected: %PUBLISH_EXE%
    echo         Service will NOT be started.
    exit /b 11
)

echo.
echo [8/9] Starting %SERVICE%...
sc.exe start "%SERVICE%" >nul
if errorlevel 1 (
    echo [ERROR] Failed to start %SERVICE%.
    exit /b 12
)

set "STATE="
for /l %%N in (1,1,30) do (
    set "STATE="
    for /f "tokens=3" %%S in ('sc.exe query "%SERVICE%" ^| findstr /I "STATE"') do set "STATE=%%S"
    if /I "!STATE!"=="RUNNING" goto SERVICE_RUNNING
    timeout /t 1 /nobreak >nul
)
echo [ERROR] Service did not reach RUNNING state within 30 seconds.
exit /b 13

:SERVICE_RUNNING
echo       Service is RUNNING.

echo.
echo [9/9] Checking dashboard port 8009...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=Get-NetTCPConnection -LocalPort 8009 -State Listen -ErrorAction SilentlyContinue; if($c){exit 0}else{exit 1}"
if errorlevel 1 (
    echo [WARN] Port 8009 is not listening yet.
    echo       Check Windows Event Viewer/service logs.
) else (
    echo       Dashboard is listening on port 8009.
)

echo.
echo ================================================================
echo DEPLOYMENT COMPLETE
echo ================================================================
echo Instance : %INSTANCE_ROOT%
echo Source   : %PROJECT%
echo Publish  : %PUBLISH_DIR%
echo Service  : %SERVICE%
echo Dashboard: http://localhost:8009
echo ================================================================
echo.
exit /b 0
