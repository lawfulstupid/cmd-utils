@echo off

if not "%~1" == "" (
	set time=%~1
) else (
	set time=5
)

echo Shutting down . . .
timeout /T %time% /nobreak

if %errorlevel% == 0 (
   shutdown /s /t 0
) else (
   echo Shutdown aborted.
   call delay 1
)