@echo off

set "flag_f= "
set flag_v=
set src=
set dst=

:parseflags
if "%~1"=="" (
	goto main
) else if "%~1"=="/?" (
	goto help
) else if "%~1"=="/F" (
	set "flag_f=/Y"
) else if "%~1"=="/f" (
	set "flag_f=/Y"
) else if "%~1"=="/V" (
	set "flag_v=1"
) else if "%~1"=="/v" (
	set "flag_v=1"
) else (
	if defined src (
		set "dst=%~1"
	) else (
		set "src=%~1"
	)
)
shift
goto parseflags

:help
echo Move all files of a directory tree to a folder.
echo.
echo FLATTEN [/F] [/V] [sourcepath]
echo FLATTEN [/F] [/V] sourcepath [destination]
echo.
echo   sourcepath	Specify the directory tree you want to flatten. If absent, use current directory.
echo   destination	Where to place the flattened directory tree. If absent, use current directory.
echo   /F		Force flatten; suppress prompting to confirm you want to overwrite an existing file.
echo   /V		Verbose; echo directories accessed.
goto :eof

:main
set "dirs= "
if not defined src set "src=%cd%"
if not defined dst set "dst=%cd%"

setlocal enabledelayedexpansion
for /r "%src%" %%d in (.) do (
	set dirs="%%~d" !dirs!
	if defined flag_v echo %%~d
	move %flag_f% "%%~d\*" "%dst%" >nul 2>&1
)

for %%d in (%dirs%) do (
	rmdir "%%~d" >nul 2>&1
)
goto :eof