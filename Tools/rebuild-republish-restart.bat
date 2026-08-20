@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM ================================================================
REM HROne ESSL Biometric - BUILD / PUBLISH / RECONFIGURE / RESTART
REM
REM The GitHub clone is BOTH the source and deployment location.
REM The installed Windows service is explicitly changed to run from:
REM   <repo>\Publish\HROneSyncService.exe
REM
REM Expected:
REM   <repo>\HROneSync\HROneSyncService\HROneSyncService.csproj
REM   <repo>\Tools\rebuild-republish-restart.bat
REM   <repo>\Publish\HROneSyncService.exe
REM
REM Run as Administrator.
REM ================================================================

set "SERVICE=HROneSyncService"
set "SCRIPT_DIR=%~dp0"
set "REPO_ROOT=%SCRIPT_DIR%.."
for %%I in ("%REPO_ROOT%") do set "REPO_ROOT=%%~fI"
set "PUBLISH_DIR=%REPO_ROOT%\Publish"
set "PUBLISH_EXE=%PUBLISH_DIR%\HROneSyncService.exe"

where dotnet >nul 2>&1 || (echo [ERROR] dotnet not found in PATH.&exit /b 1)
net session >nul 2>&1 || (echo [ERROR] Run this BAT as Administrator.&exit /b 2)

set "PROJECT="
for /r "%REPO_ROOT%" %%F in (HROneSyncService.csproj) do if not defined PROJECT set "PROJECT=%%~fF"
if not defined PROJECT (echo [ERROR] HROneSyncService.csproj not found under %REPO_ROOT%.&exit /b 3)
if not exist "%PUBLISH_DIR%" mkdir "%PUBLISH_DIR%"
cd /d "%REPO_ROOT%"

echo.
echo ================================================================
echo SOURCE     : %REPO_ROOT%
echo PROJECT    : %PROJECT%
echo DEPLOYMENT : %PUBLISH_DIR%
echo SERVICE    : %SERVICE%
echo ================================================================
echo.

echo [1/8] Checking installed service...
sc.exe query "%SERVICE%" >nul 2>&1
if errorlevel 1 goto INSTALL_SERVICE

echo [2/8] Stopping %SERVICE%...
sc.exe stop "%SERVICE%" >nul 2>&1
set "STATE="
for /l %%N in (1,1,30) do (
  for /f "tokens=3" %%S in ('sc.exe query "%SERVICE%" ^| findstr /I "STATE"') do set "STATE=%%S"
  if /I "!STATE!"=="STOPPED" goto STOPPED
  timeout /t 1 /nobreak >nul
)
echo [ERROR] Service did not stop within 30 seconds.&exit /b 4

:STOPPED
echo       Service stopped.

echo [3/8] Restoring dependencies...
dotnet restore "%PROJECT%" || (echo [ERROR] dotnet restore failed.&exit /b 5)

echo [4/8] Cleaning Release build...
dotnet clean "%PROJECT%" -c Release --no-restore || (echo [ERROR] dotnet clean failed.&exit /b 6)

echo [5/8] Building Release...
dotnet build "%PROJECT%" -c Release --no-restore || (echo [ERROR] dotnet build failed. Service remains stopped.&exit /b 7)

echo [6/8] Publishing INTO THE GITHUB CLONE...
echo       %PUBLISH_DIR%
dotnet publish "%PROJECT%" -c Release --no-restore -o "%PUBLISH_DIR%" || (echo [ERROR] dotnet publish failed. Service remains stopped.&exit /b 8)
if not exist "%PUBLISH_EXE%" (echo [ERROR] %PUBLISH_EXE% was not created.&exit /b 9)

echo [7/8] RECONFIGURING WINDOWS SERVICE TO THE GITHUB CLONE...
echo       %PUBLISH_EXE%
sc.exe config "%SERVICE%" binPath= "\"%PUBLISH_EXE%\""
if errorlevel 1 (echo [ERROR] Windows service binPath could not be changed.&exit /b 10)
sc.exe config "%SERVICE%" start= auto >nul
sc.exe failure "%SERVICE%" reset= 86400 actions= restart/60000/restart/60000/restart/60000 >nul 2>&1

REM Verify SCM configuration contains the new repository path.
set "BINPATH="
for /f "tokens=2,*" %%A in ('sc.exe qc "%SERVICE%" ^| findstr /I "BINARY_PATH_NAME"') do set "BINPATH=%%B"
echo       SCM binary path: !BINPATH!
echo !BINPATH! | findstr /I /C:"%PUBLISH_EXE%" >nul
if errorlevel 1 (echo [ERROR] SCM is still pointing somewhere else. Service will NOT be started.&exit /b 11)

goto START_SERVICE

:INSTALL_SERVICE
echo       Service is not installed. Installing it from the GitHub clone.
echo [2/8] Restoring dependencies...
dotnet restore "%PROJECT%" || (echo [ERROR] dotnet restore failed.&exit /b 5)
echo [4/8] Cleaning Release build...
dotnet clean "%PROJECT%" -c Release --no-restore || (echo [ERROR] dotnet clean failed.&exit /b 6)
echo [5/8] Building Release...
dotnet build "%PROJECT%" -c Release --no-restore || (echo [ERROR] dotnet build failed.&exit /b 7)
echo [6/8] Publishing INTO THE GITHUB CLONE...
dotnet publish "%PROJECT%" -c Release --no-restore -o "%PUBLISH_DIR%" || (echo [ERROR] dotnet publish failed.&exit /b 8)
if not exist "%PUBLISH_EXE%" (echo [ERROR] %PUBLISH_EXE% was not created.&exit /b 9)
sc.exe create "%SERVICE%" binPath= "\"%PUBLISH_EXE%\"" start= auto DisplayName= "HROne ESSL Biometric Sync Service"
if errorlevel 1 (echo [ERROR] Could not create Windows service.&exit /b 10)
sc.exe description "%SERVICE%" "ESSL/eBioServer to HROne biometric attendance synchronization service."
sc.exe failure "%SERVICE%" reset= 86400 actions= restart/60000/restart/60000/restart/60000 >nul 2>&1

:START_SERVICE
echo [8/8] Starting %SERVICE%...
sc.exe start "%SERVICE%" >nul
if errorlevel 1 (echo [ERROR] Failed to start %SERVICE%. Check Event Viewer.&exit /b 12)
set "STATE="
for /l %%N in (1,1,30) do (
  for /f "tokens=3" %%S in ('sc.exe query "%SERVICE%" ^| findstr /I "STATE"') do set "STATE=%%S"
  if /I "!STATE!"=="RUNNING" goto RUNNING
  timeout /t 1 /nobreak >nul
)
echo [ERROR] Service did not reach RUNNING state within 30 seconds.&exit /b 13

:RUNNING
echo       Service is RUNNING.
echo.
echo Final Windows service configuration:
sc.exe qc "%SERVICE%" | findstr /I "BINARY_PATH_NAME START_TYPE"
echo.
echo Checking dashboard port 8009...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=Get-NetTCPConnection -LocalPort 8009 -State Listen -ErrorAction SilentlyContinue;if($c){exit 0}else{exit 1}"
if errorlevel 1 echo [WARN] Port 8009 is not listening yet. Check service logs/Event Viewer.
if not errorlevel 1 echo       Dashboard is listening on port 8009.

echo.
echo ================================================================
echo DEPLOYMENT COMPLETE
 echo Source     : %REPO_ROOT%
echo Publish    : %PUBLISH_DIR%
echo Service    : %SERVICE%
echo Dashboard  : http://localhost:8009
echo ================================================================
exit /b 0
