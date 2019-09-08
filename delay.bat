@echo off

if ".%~1"=="./?" goto help
goto delay

:help
echo DELAY n [keys ^| *]
echo Causes a delay
echo n	Number of seconds the delay should last.
echo keys	Keys used to interrupt the delay.
echo		One or more of [a-z0-9] or use wildcard (*).
goto:eof

:delay
set "options=%~2"
if ".%~2"=="." set "options= "
if ".%~2"==".*" set "options=abcdefghijklmnopqrstuvwxyz0123456789"
choice /c ¬%options% /d ¬ /t %~1 /n >nul
goto:eof