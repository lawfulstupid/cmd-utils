@echo off

set ext=flag

if "%~1" == "--suppress" (
	echo. > "%~dp0\%date%.%ext%"
	if exist "%~dp0\%date%.%ext%" (
		echo Night Time suppressed for %date%.
	) else (
		echo Suppression failed.
	)
	pause
	goto:eof
)

set time=%~1
if "%time%" == "" set time=15

if /i %time% EQU 0 (
	if exist "%~dp0\*.%ext%" (
		del "%~dp0\*.%ext%" >nul 2>&1
		goto:eof
	)
)

echo Good Night.
choice /c 0123456789qwertyuiopasdfghjklzxcvbnm /d 0 /t %time% /n
if %errorlevel% EQU 1 (
	shutdown /s /t 0
) else (
	echo.
	echo Shut down snoozed.
	echo You have 5 minutes.
	echo.
	pause
)