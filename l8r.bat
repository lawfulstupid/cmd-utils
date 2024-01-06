@echo off

if not "%~1" == "" (
	set time=%~1
) else (
	set time=5
)

echo Hibernating . . .
timeout /T %time% /nobreak

if %errorlevel% == 0 (
   shutdown /h /t 0
) else (
   echo Hibernation aborted.
   call delay 1
)
