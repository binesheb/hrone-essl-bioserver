@echo off
setlocal EnableExtensions

REM Location-aware dashboard-triggered update.
REM This file lives beside rebuild-republish-restart.bat.
set "SCRIPT_DIR=%~dp0"
call "%SCRIPT_DIR%rebuild-republish-restart.bat"
exit /b %ERRORLEVEL%
