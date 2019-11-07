@echo off
setlocal EnableDelayedExpansion
if "%~1" == "/?" goto help

set str=%~1
for /L %%N in (0,1,8192) do (
	if "!str!"=="" (
		set size=%%N
		goto break
	) else (
		set str=!str:~1!
	)
)

:break
endlocal & set size=%size%
if "%~2" == "" (
	echo %size%
) else (
	set %~2=%size%
)
goto:eof

:help
call fx /fg:aqua
echo LENGTH ^<string^> [^<var^>]
call fx /r
echo Computes the length of a string.
echo Writes to variable if present, otherwise prints to stdout.
goto:eof