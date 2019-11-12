@echo off
setlocal EnableDelayedExpansion
	set casing=
	if /I "/I"=="%~1" shift & set casing=/I
	set found=0
	
	:loop
	if %casing% "%switch%"=="%~1" set found=1
	shift
	if "%~1"=="" goto endloop
	goto loop
	:endloop
endlocal & if /I %found% EQU 1 default
exit /b 1