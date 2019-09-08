@echo off

set time=5

echo Shutting down in %time% seconds . . .
echo Press any key to cancel.
call delay %time% *

if %errorlevel% == 1 (
   shutdown /s /t 0
) else (
   echo Shutdown aborted.
   call delay 1
)
