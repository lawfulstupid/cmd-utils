@echo off
setlocal enabledelayedexpansion

set "userbin=%USERPROFILE%\bin"
set "filename=."
set "command=@cd ."

for /l %%I in (0,1,%~1) do (
   echo !command!>!userbin!\!filename!#.bat
   set filename=!filename!.
   set command=!command!\..
)
