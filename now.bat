@echo off

:main
setlocal EnableDelayedExpansion
	set outvar=
	if ".%~1" == "./?" (
		goto :help
	)
	
	if not ".%~1" == "." set outvar=%~1
	set FIXEDTIME=!time: =0!
	set /A FIXEDTIME=(1!FIXEDTIME:~0,2!-100)*60*60*1000 + (1!FIXEDTIME:~3,2!-100)*60*1000 + (1!FIXEDTIME:~6,2!)*1000 + (1!FIXEDTIME:~9,2!-100)*10

	if not defined outvar echo %FIXEDTIME%
endlocal & if not "%outvar%" == "" set %outvar%=%FIXEDTIME%
goto:eof

:help
call fx /fg:aqua
echo NOW [^<var^>]
call fx /r
echo Gets current system time in milliseconds
echo;
echo Options:
echo;   ^<var^>   Will write result out to variable instead of printing to screen.
goto:eof
