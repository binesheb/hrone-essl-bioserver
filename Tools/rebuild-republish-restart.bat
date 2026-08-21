@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM ================================================================
REM HROne ESSL Biometric - LOCATION-AWARE FORCE UPDATE / BUILD / DEPLOY
REM GitHub instance: FORCE syncs origin/main and discards ALL local
REM tracked/staged/untracked changes before rebuilding.
REM Production instance: if no .git folder exists, skips Git update.
REM The instance is always determined from this BAT's own location.
REM IMPORTANT: the Windows service is stopped BEFORE Git sync so that
REM published DLL/EXE files cannot be locked during reset/clean.
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
echo FORCE UPDATE MODE - LOCAL GIT CHANGES WILL BE DISCARDED
echo ================================================================
echo Instance : %INSTANCE_ROOT%
echo Source   : %PROJECT%
echo Publish  : %PUBLISH_DIR%
echo Service  : %SERVICE%
echo ================================================================
echo.

REM 1. Stop service BEFORE touching Git or published files.
sc.exe query "%SERVICE%" >nul 2>&1
if not errorlevel 1 (
    echo [1/9] Stopping %SERVICE% before update...
    sc.exe stop "%SERVICE%" >nul 2>&1
    powershell -NoProfile -ExecutionPolicy Bypass -Command "$deadline=(Get-Date).AddSeconds(30); do { $s=(Get-Service -Name '%SERVICE%' -ErrorAction SilentlyContinue).Status; if($s -eq 'Stopped'){exit 0}; Start-Sleep -Milliseconds 500 } while((Get-Date) -lt $deadline); exit 1"
    if errorlevel 1 (echo [ERROR] %SERVICE% did not reach STOPPED state. Update aborted.& exit /b 5)
    echo       Service is STOPPED.
) else (
    echo [1/9] %SERVICE% is not installed. It will be created after publish.
)

REM Release any remaining process lock held by THIS published executable.
echo       Checking for remaining HROneSyncService process locks...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$exe=(Resolve-Path -LiteralPath '%PUBLISH_EXE%' -ErrorAction SilentlyContinue).Path; if($exe){Get-CimInstance Win32_Process -ErrorAction SilentlyContinue | Where-Object { $_.ExecutablePath -eq $exe -and $_.ProcessId -ne $PID } | ForEach-Object { try { Stop-Process -Id $_.ProcessId -Force -ErrorAction Stop } catch {} }}; Start-Sleep -Milliseconds 500"
echo       Published executable is released for update.

REM 2. If this is a Git clone, force it to exactly match origin/main.
if exist "%INSTANCE_ROOT%\.git\" (
    echo.
    echo [2/9] Git repository detected. Forcing origin/main...
    git --version >nul 2>&1
    if errorlevel 1 (echo [ERROR] Git was not found in PATH. Service remains stopped.& exit /b 15)

    echo       Fetching latest origin/main...
    git fetch origin main
    if errorlevel 1 (echo [ERROR] Git fetch failed. Service remains stopped.& exit /b 18)

    echo       Discarding local tracked and staged changes...
    git reset --hard origin/main
    if errorlevel 1 (echo [ERROR] Git reset failed. Service remains stopped.& exit /b 19)

    echo       Removing local untracked files and folders...
    git clean -fd
    if errorlevel 1 (echo [ERROR] Git clean failed. Service remains stopped.& exit /b 20)

    echo       Verifying exact match with origin/main...
    for /f %%A in ('git rev-parse HEAD') do set "LOCAL_SHA=%%A"
    for /f %%A in ('git rev-parse origin/main') do set "REMOTE_SHA=%%A"
    if /I not "!LOCAL_SHA!"=="!REMOTE_SHA!" (echo [ERROR] Local repository does not match origin/main. Service remains stopped.& exit /b 21)
    echo       Repository is now exactly at: !REMOTE_SHA!
) else (
    echo.
    echo [2/9] No Git repository detected. Using this deployment instance as-is.
)

REM 3. Clean source build artifacts.
echo.
echo [3/9] Cleaning source build artifacts...
if exist "%PROJECT_DIR%\bin" (rmdir /s /q "%PROJECT_DIR%\bin" & if exist "%PROJECT_DIR%\bin" (echo [ERROR] Could not remove bin folder. Service remains stopped.& exit /b 6))
if exist "%PROJECT_DIR%\obj" (rmdir /s /q "%PROJECT_DIR%\obj" & if exist "%PROJECT_DIR%\obj" (echo [ERROR] Could not remove obj folder. Service remains stopped.& exit /b 6))
echo       Source bin/obj cleaned.

REM 4. Restore.
echo.
echo [4/9] Restoring dependencies...
dotnet restore "%PROJECT%"
if errorlevel 1 (echo [ERROR] Restore failed. Service remains stopped.& exit /b 7)

REM 5. Build.
echo.
echo [5/9] Building Release...
dotnet build "%PROJECT%" -c Release --no-restore
if errorlevel 1 (echo [ERROR] Build failed. Service remains stopped.& exit /b 8)

REM 6. Publish.
echo.
echo [6/9] Publishing to:
echo       %PUBLISH_DIR%
dotnet publish "%PROJECT%" -c Release --no-restore -o "%PUBLISH_DIR%"
if errorlevel 1 (echo [ERROR] Publish failed. Service remains stopped.& exit /b 9)
if not exist "%PUBLISH_EXE%" (echo [ERROR] Published executable not found: %PUBLISH_EXE%& exit /b 10)

REM 7. Configure Windows Service to THIS instance.
echo.
echo [7/9] Switching Windows service to THIS INSTANCE...
echo       Target: %PUBLISH_EXE%
sc.exe query "%SERVICE%" >nul 2>&1
if errorlevel 1 (
    sc.exe create "%SERVICE%" binPath= "%PUBLISH_EXE%" start= auto DisplayName= "HROneSyncService"
    if errorlevel 1 (echo [ERROR] Could not create Windows service.& exit /b 11)
) else (
    sc.exe config "%SERVICE%" binPath= "%PUBLISH_EXE%" start= auto
    if errorlevel 1 (echo [ERROR] Could not change Windows service path.& exit /b 11)
)
sc.exe description "%SERVICE%" "HROne ESSL biometric synchronization service." >nul 2>&1
sc.exe failure "%SERVICE%" reset= 86400 actions= restart/60000/restart/60000/restart/60000 >nul 2>&1

REM 8. Verify actual SCM ImagePath.
echo.
echo [8/9] Verifying Windows service path...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$expected=(Resolve-Path -LiteralPath '%PUBLISH_EXE%').Path; $svc=Get-CimInstance Win32_Service -Filter \"Name='%SERVICE%'\"; if($null -eq $svc){Write-Error 'Service not found after configuration.';exit 1}; $actual=$svc.PathName; Write-Host ('       SCM Path: '+$actual); $normalized=$actual.Trim(); if($normalized.StartsWith('''') -and $normalized.EndsWith('''')){$normalized=$normalized.Substring(1,$normalized.Length-2)}; if($normalized -ne $expected){Write-Error ('Service is mapped to the wrong instance. Expected: '+$expected+' ; Actual: '+$actual);exit 2};exit 0"
if errorlevel 1 (echo [ERROR] Windows service path verification failed. Service will NOT be started.& exit /b 12)
echo       Service path verified for THIS INSTANCE.

REM 9. Start service and verify dashboard.
echo.
echo [9/9] Starting %SERVICE%...
sc.exe start "%SERVICE%" >nul
if errorlevel 1 (echo [ERROR] Failed to start %SERVICE%.& exit /b 13)
powershell -NoProfile -ExecutionPolicy Bypass -Command "$deadline=(Get-Date).AddSeconds(30); do { $s=(Get-Service -Name '%SERVICE%' -ErrorAction SilentlyContinue).Status; if($s -eq 'Running'){exit 0}; Start-Sleep -Milliseconds 500 } while((Get-Date) -lt $deadline); exit 1"
if errorlevel 1 (echo [ERROR] Service did not reach RUNNING state.& exit /b 14)
echo       Service is RUNNING.
echo       Checking dashboard port 8009...
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