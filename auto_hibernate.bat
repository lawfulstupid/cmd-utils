@REM hibernate
@echo off

if "%1" == "" (
	set time=5
) else (
	set time=%1
)

echo Hibernating in %time% seconds . . .
echo Press any key to cancel.
choice /c ¬abcdefghijklmnopqrstuvwxyz0123456789 /n /t %time% /d ¬ >nul

if %errorlevel% == 1 (
	shutdown /h /t 0
) else (
	echo Hibernation aborted.
	call delay 1
)