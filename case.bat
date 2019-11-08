@echo off
setlocal EnableDelayedExpansion
	set casing=
	set options=%*
	if /I "%~1"=="/I" (
		set casing=/I
		for /f "tokens=1,*" %%A in ("%*") do set options=%%B
	)
	
	set found=0
	for %%A in (!options!) do (
		if %casing% "%switch%"=="%%~A" set found=1
	)
endlocal & if /I %found% EQU 1 default
exit /b 1