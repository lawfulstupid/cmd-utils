@echo off
setlocal enabledelayedexpansion

set "filename=%~dp0."
set "command=@cd ."

for /l %%I in (0,1,%~1) do (
   echo !command!>!filename!#.bat
   set filename=!filename!.
   set command=!command!\..
)
