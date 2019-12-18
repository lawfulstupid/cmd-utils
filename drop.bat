@echo off
if "%~1"=="/?" goto help
if "%~2"=="" %0 1 "%~1"
for /f "tokens=%~1,*" %%A in ("!%~2!") do (
	set %~2=%%B
)
goto:eof


:help
setlocal EnableDelayedExpansion
	call fx /fg:aqua
	echo DROP [^<N^>] ^<argvar^>
	call fx /r
	echo Removes first [N] list item(s) from a variable. Only works from within a delayed-expansion local scope.
	echo;
	echo Example usage:
	echo;   set var=foo bar baz maz
	echo;   call drop 2 var
	echo;   echo %%var%%
	echo;~^> baz maz
endlocal
goto:eof
