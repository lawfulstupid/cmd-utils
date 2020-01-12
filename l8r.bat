@echo off

set time=5

echo Hibernating in %time% seconds . . .
echo Press any key to cancel.
call delay %time% *

if %errorlevel% == 1 (
   shutdown /h /t 0
) else (
   echo Hibernation aborted.
   call delay 1
)
