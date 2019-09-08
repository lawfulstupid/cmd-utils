@echo off

if ".%~1"=="./?" goto help
if ".%~1"=="."   goto default
goto openAll

:help
echo Opens a directory in Windows File Explorer.
echo.
echo OPEN [drive:][path]
echo.
echo If no path is supplied, the current directory is opened.
goto:eof

:default
open "%cd%"
goto:eof

:openAll
for %%A in (%*) do explorer "%%~A"
goto:eof
