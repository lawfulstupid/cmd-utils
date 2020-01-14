@echo off
setlocal EnableDelayedExpansion
	set message=
	set notFirst=0
	for %%L in (%*) do (
		if /I !notFirst! EQU 1 (
			set message=!message!^


		)
		set message=!message!%%~L
		set notFirst=1
	)
	call bell
	msg * /w "!message!"
endlocal