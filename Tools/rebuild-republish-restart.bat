@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM ================================================================
REM HROne ESSL Biometric - LOCATION-AWARE BUILD / DEPLOY / RESTART
REM No mandatory deployment location. The instance is determined
REM from this BAT's own Tools folder.
REM
REM Instance structure:
REM   <INSTANCE>\Tools\this.bat
REM   <INSTANCE>\HROneSync\HROneSyncService\HROneSyncService.csproj
REM   <INSTANCE>\HROneSync\Publish\HROneSyncService.exe
REM
REM GitHub and production are independent instances. This script only
REM operates on the instance that contains the BAT being executed.
REM ================================================================

set "SERVICE=HROneSyncService"
set "SCRIPT_DIR=%~dp0"
for %%I in ("%SCRIPT_DIR%..") do set "INSTANCE_ROOT=%%~fI"
set "SOURCE_ROOT=%INSTANCE_ROOT%\HROneSync"
set "PROJECT=%SOURCE_ROOT%\HROneSyncService\HROneSyncService.csproj"
set "PROJECT_DIR=%SOURCE_ROOT%\HROneSyncService"
set "PUBLISH_DIR=%SOURCE_ROOT%\Publish"
set "PUBLISH_EXE=%PUBLISH_DIR%\HROneSyncService.exe"

where dotnet >nul 2>&1 || (echo [ERROR] dotnet was not found in PATH.& exit /b 1)
net session >nul 2>&1 || (echo [ERROR] Run this BAT as Administrator.& exit /b 2)

if not exist "%PROJECT%" (echo [ERROR] Service project not found: %PROJECT%& exit /b 3)
if not exist "%PUBLISH_DIR%\" (echo [ERROR] Existing Publish folder not found: %PUBLISH_DIR%& exit /b 4)

cd /d "%INSTANCE_ROOT%"

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

REM ---------------------------------------------------------------
REM 1. Stop the Windows service before touching build/deployment files.
REM ---------------------------------------------------------------
sc.exe query "%SERVICE%" >nul 2>&1
if not errorlevel 1 (
    echo [1/9] Stopping %SERVICE%...
    sc.exe stop "%SERVICE%" >nul 2>&1
    powershell -NoProfile -ExecutionPolicy Bypass -Command "$deadline=(Get-Date).AddSeconds(30); do { $s=(Get-Service -Name '%SERVICE%' -ErrorAction SilentlyContinue).Status; if($s -eq 'Stopped'){exit 0}; Start-Sleep -Milliseconds 500 } while((Get-Date) -lt $deadline); exit 1"
    if errorlevel 1 (echo [ERROR] %SERVICE% did not reach STOPPED state.& exit /b 5)
) else (
    echo [1/9] %SERVICE% is not installed. It will be created after publish.
)
echo       Service is STOPPED.

REM ---------------------------------------------------------------
REM 2. Clean old source build artifacts FIRST.
REM    This MUST happen before restore. Deleting obj after restore removes
REM    project.assets.json and causes NETSDK1004 during --no-restore build.
REM ---------------------------------------------------------------
echo.
echo [2/9] Cleaning source build artifacts...
if exist "%PROJECT_DIR%\bin" (
    rmdir /s /q "%PROJECT_DIR%\bin"
    if exist "%PROJECT_DIR%\bin" (echo [ERROR] Could not remove bin folder.& exit /b 6)
)
if exist "%PROJECT_DIR%\obj" (
    rmdir /s /q "%PROJECT_DIR%\obj"
    if exist "%PROJECT_DIR%\obj" (echo [ERROR] Could not remove obj folder.& exit /b 6)
)
echo       Source bin/obj cleaned.

REM ---------------------------------------------------------------
REM 3. Restore AFTER cleaning so project.assets.json is regenerated.
REM ---------------------------------------------------------------
echo.
echo [3/9] Restoring dependencies...
dotnet restore "%PROJECT%"
if errorlevel 1 (echo [ERROR] Restore failed. Service remains stopped.& exit /b 7)

REM ---------------------------------------------------------------
REM 4. Build without restore. The restore above created fresh assets.
REM ---------------------------------------------------------------
echo.
echo [4/9] Building Release...
dotnet build "%PROJECT%" -c Release --no-restore
if errorlevel 1 (echo [ERROR] Build failed. Service remains stopped.& exit /b 8)

REM ---------------------------------------------------------------
REM 5. Publish to this instance's EXISTING Publish folder.
REM ---------------------------------------------------------------
echo.
echo [5/9] Publishing to:
echo       %PUBLISH_DIR%
dotnet publish "%PROJECT%" -c Release --no-restore -o "%PUBLISH_DIR%"
if errorlevel 1 (echo [ERROR] Publish failed. Service remains stopped.& exit /b 9)
if not exist "%PUBLISH_EXE%" (echo [ERROR] Published executable not found: %PUBLISH_EXE%& exit /b 10)

echo.
echo [6/9] Switching Windows service to THIS INSTANCE...
echo       Target: %PUBLISH_EXE%

REM Use PowerShell only to construct the exact quoted ImagePath argument,
REM then call the native Service Control Manager.
powershell -NoProfile -ExecutionPolicy Bypass -Command "$name='%SERVICE%'; $path=(Resolve-Path -LiteralPath '%PUBLISH_EXE%').Path; $quoted='\"'+$path+'\"'; $svc=Get-Service -Name $name -ErrorAction SilentlyContinue; if($null -eq $svc){& sc.exe create $name ('binPath= '+$quoted) 'start= auto' 'DisplayName= HROneSyncService'; $code=$LASTEXITCODE}else{& sc.exe config $name ('binPath= '+$quoted) 'start= auto'; $code=$LASTEXITCODE}; if($code -ne 0){Write-Error ('SCM service configuration failed with exit code '+$code);exit $code}; exit 0"
if errorlevel 1 (echo [ERROR] Could not switch Windows service to this instance.& exit /b 11)

sc.exe description "%SERVICE%" "HROne ESSL biometric synchronization service." >nul 2>&1
sc.exe failure "%SERVICE%" reset= 86400 actions= restart/60000/restart/60000/restart/60000 >nul 2>&1

echo.
echo [7/9] Verifying Windows service path...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$expected=(Resolve-Path -LiteralPath '%PUBLISH_EXE%').Path; $svc=Get-CimInstance Win32_Service -Filter \"Name='%SERVICE%'\"; if($null -eq $svc){Write-Error 'Service not found after configuration.';exit 1}; $actual=$svc.PathName; Write-Host ('       SCM Path: '+$actual); $normalized=($actual -replace '^\"|\"$',''); if($normalized -ne $expected){Write-Error ('Service is mapped to the wrong instance. Expected: '+$expected+' ; Actual: '+$actual);exit 2};exit 0"
if errorlevel 1 (echo [ERROR] Windows service path verification failed. Service will NOT be started.& exit /b 12)
echo       Service path verified for THIS INSTANCE.

echo.
echo [8/9] Starting %SERVICE%...
sc.exe start "%SERVICE%" >nul
if errorlevel 1 (echo [ERROR] Failed to start %SERVICE%.& exit /b 13)
powershell -NoProfile -ExecutionPolicy Bypass -Command "$deadline=(Get-Date).AddSeconds(30); do { $s=(Get-Service -Name '%SERVICE%' -ErrorAction SilentlyContinue).Status; if($s -eq 'Running'){exit 0}; Start-Sleep -Milliseconds 500 } while((Get-Date) -lt $deadline); exit 1"
if errorlevel 1 (echo [ERROR] Service did not reach RUNNING state.& exit /b 14)
echo       Service is RUNNING.

echo.
echo [9/9] Checking dashboard port 8009...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=Get-NetTCPConnection -LocalPort 8009 -State Listen -ErrorAction SilentlyContinue;if($c){exit 0}else{exit 1}"
if errorlevel 1 (echo [WARN] Port 8009 is not listening yet.) else (echo       Dashboard is listening on port 8009.)

echo.
echo ================================================================
echo DEPLOYMENT COMPLETE
echo ================================================================
echo Instance : %INSTANCE_ROOT%
echo Publish  : %PUBLISH_DIR%
echo Service  : %SERVICE%
echo Dashboard: http://localhost:8009
echo ================================================================
exit /b 0
