@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM ================================================================
REM HROne ESSL Biometric - LOCATION-AWARE BUILD / DEPLOY / RESTART
REM
REM There is NO mandatory installation/deployment path.
REM The instance is determined from THIS BAT's location.
REM
REM Expected instance structure:
REM   <INSTANCE>\HROneSync\HROneSyncService\HROneSyncService.csproj
REM   <INSTANCE>\HROneSync\Publish\HROneSyncService.exe
REM   <INSTANCE>\Tools\this-bat.bat
REM
REM Examples:
REM   C:\hrone-essl-bioserver\Tools\this-bat.bat
REM     -> source:  C:\hrone-essl-bioserver\HROneSync\HROneSyncService
REM     -> publish: C:\hrone-essl-bioserver\HROneSync\Publish
REM
REM   C:\HROneSync\Tools\this-bat.bat
REM     -> source:  C:\HROneSync\HROneSyncService\HROneSyncService.csproj
REM     -> publish: C:\HROneSync\Publish
REM
REM The script NEVER assumes C:\HROneSync, C:\hrone-essl-bioserver,
REM or any other fixed location. It never modifies another instance.
REM
REM Every deployment:
REM   1. Resolves the instance from this BAT's own Tools folder.
REM   2. Finds the source project using the instance's actual structure.
REM   3. Uses the EXISTING HROneSync\Publish folder for that instance.
REM   4. Stops HROneSyncService and waits for STOPPED.
REM   5. Restores, cleans, builds and publishes that instance only.
REM   6. Configures Windows Service binPath to that instance's EXE.
REM   7. Starts the service and verifies RUNNING.
REM   8. Checks dashboard port 8009.
REM
REM Run as Administrator.
REM ================================================================

set "SERVICE=HROneSyncService"
set "SCRIPT_DIR=%~dp0"
for %%I in ("%SCRIPT_DIR%..") do set "INSTANCE_ROOT=%%~fI"

REM The repository/deployment structure is authoritative.
set "SOURCE_ROOT=%INSTANCE_ROOT%\HROneSync"
set "PROJECT=%SOURCE_ROOT%\HROneSyncService\HROneSyncService.csproj"
set "PUBLISH_DIR=%SOURCE_ROOT%\Publish"
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
    echo [ERROR] Could not find HROneSyncService.csproj for this instance.
    echo         Expected:
    echo         %PROJECT%
    echo.
    echo Put this BAT in the Tools folder belonging to the instance you want to deploy.
    exit /b 3
)

REM Publish MUST already exist. Do not invent a different publish location.
if not exist "%PUBLISH_DIR%\" (
    echo [ERROR] Existing Publish folder was not found.
    echo         Expected:
    echo         %PUBLISH_DIR%
    echo.
    echo This script does not create or relocate the deployment structure.
    exit /b 4
)

cd /d "%INSTANCE_ROOT%"

set "SERVICE_EXISTS=0"
sc.exe query "%SERVICE%" >nul 2>&1
if not errorlevel 1 set "SERVICE_EXISTS=1"

echo.
echo ================================================================
echo LOCATION-AWARE HROne ESSL DEPLOYMENT
echo ================================================================
echo Instance : %INSTANCE_ROOT%
echo Source   : %PROJECT%
echo Publish  : %PUBLISH_DIR%
echo Service  : %SERVICE%
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
    echo         Deployment aborted. Published files were NOT changed.
    exit /b 5
) else (
    echo [1/9] %SERVICE% is not installed. Build/publish will continue.
)

:SERVICE_STOPPED
echo       Service stopped.

echo.
echo [2/9] Restoring dependencies...
dotnet restore "%PROJECT%"
if errorlevel 1 (
    echo [ERROR] Restore failed. Service remains stopped.
    exit /b 6
)

echo.
echo [3/9] Cleaning Release build...
dotnet clean "%PROJECT%" -c Release --no-restore
if errorlevel 1 (
    echo [ERROR] Clean failed. Service remains stopped.
    exit /b 7
)

echo.
echo [4/9] Building Release...
dotnet build "%PROJECT%" -c Release --no-restore
if errorlevel 1 (
    echo [ERROR] Build failed. Service remains stopped.
    exit /b 8
)

echo.
echo [5/9] Publishing to the EXISTING Publish folder...
echo       %PUBLISH_DIR%
dotnet publish "%PROJECT%" -c Release --no-restore -o "%PUBLISH_DIR%"
if errorlevel 1 (
    echo [ERROR] Publish failed. Service remains stopped.
    exit /b 9
)

if not exist "%PUBLISH_EXE%" (
    echo [ERROR] Published executable was not found:
    echo         %PUBLISH_EXE%
    echo         Service remains stopped.
    exit /b 10
)

echo.
echo [6/9] Configuring Windows service for THIS INSTANCE...
if "%SERVICE_EXISTS%"=="0" (
    sc.exe create "%SERVICE%" binPath= "\"%PUBLISH_EXE%\"" start= auto DisplayName= "HROne ESSL Biometric Sync Service"
    if errorlevel 1 (
        echo [ERROR] Could not create Windows service.
        exit /b 11
    )
    sc.exe description "%SERVICE%" "ESSL/eBioServer to HROne biometric attendance synchronization service."
) else (
    sc.exe config "%SERVICE%" binPath= "\"%PUBLISH_EXE%\"" start= auto
    if errorlevel 1 (
        echo [ERROR] Could not update Windows service binPath.
        exit /b 11
    )
)

REM Restart automatically only after unexpected service failures.
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
    exit /b 12
)

echo.
echo [8/9] Starting %SERVICE%...
sc.exe start "%SERVICE%" >nul
if errorlevel 1 (
    echo [ERROR] Failed to start %SERVICE%.
    exit /b 13
)

set "STATE="
for /l %%N in (1,1,30) do (
    set "STATE="
    for /f "tokens=3" %%S in ('sc.exe query "%SERVICE%" ^| findstr /I "STATE"') do set "STATE=%%S"
    if /I "!STATE!"=="RUNNING" goto SERVICE_RUNNING
    timeout /t 1 /nobreak >nul
)
echo [ERROR] Service did not reach RUNNING state within 30 seconds.
exit /b 14

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
