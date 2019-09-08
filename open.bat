@echo off
if "%~1"=="/?" (
	echo Opens a directory in Windows File Explorer.
	echo.
	echo OPEN [drive:][path]
	echo.
	echo If no path is supplied, the current directory is opened.
	goto:eof
)

if "%~1"=="" (
	explorer "%cd%"
) else (
	explorer "%~1"
)