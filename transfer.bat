@echo off
setlocal EnableDelayedExpansion
for /d %%D in (%*) do (
	echo ===== %%~pnxD
	xcopy "%%~dpnxD" "B:%%~pnxD" /E /V /I /H /B
	if !errorlevel!==0 rmdir /s /q "%%~dpnxD"
)
bell