@REM hibernate
@echo off

if "%1" == "" (
	set time=5
) else (
	set time=%1
)

echo Shutting down in %time% seconds . . .
echo Press any key to cancel.
choice /c ¬abcdefghijklmnopqrstuvwxyz0123456789 /n /t %time% /d ¬ >nul

if %errorlevel% == 1 (
	shutdown /s /t 0
) else (
	echo Shutdown aborted.
	call delay 1
)