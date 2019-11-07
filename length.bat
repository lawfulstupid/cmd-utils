@echo off
setlocal EnableDelayedExpansion
set str=%~1
for /L %%N in (0,1,8192) do (
	if "!str!"=="" (
		echo %%N
		goto:eof
	) else (
		set str=!str:~1!
	)
)
endlocal
goto:eof