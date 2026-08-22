@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM Dashboard-triggered updater with visible progress state.
set "SCRIPT_DIR=%~dp0"
set "STATUS=%ProgramData%\HROneSyncService\update-status.json"
if not exist "%ProgramData%\HROneSyncService\" mkdir "%ProgramData%\HROneSyncService"

>"%STATUS%" echo {"status":"running","stage":"Starting","progress":5,"message":"Update requested.","startedAt":"%date% %time%","completedAt":null,"commit":null,"error":null}
call "%SCRIPT_DIR%rebuild-republish-restart.bat" > "%SCRIPT_DIR%update-output.log" 2>&1
set "RC=%ERRORLEVEL%"
if "%RC%"=="0" (
  for /f %%A in ('git -C "%SCRIPT_DIR%.." rev-parse HEAD 2^>nul') do set "SHA=%%A"
  >"%STATUS%" echo {"status":"completed","stage":"Completed","progress":100,"message":"Update completed successfully. Service is running.","startedAt":"%date% %time%","completedAt":"%date% %time%","commit":"!SHA!","error":null}
) else (
  >"%STATUS%" echo {"status":"failed","stage":"Failed","progress":100,"message":"Update failed. See update-output.log for details.","startedAt":"%date% %time%","completedAt":"%date% %time%","commit":null,"error":"Exit code %RC%"}
)
exit /b %RC%
