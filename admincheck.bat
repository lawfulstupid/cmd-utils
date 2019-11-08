@echo off
setlocal
verify >nul
dir %windir%\system32\config\systemprofile >nul 2>&1
if errorlevel 1 (
	set role=user
) else (
	set role=admin
)
if "%~1" == "" echo %role%
endlocal & if not "%~1" == "" set %~1=%role%