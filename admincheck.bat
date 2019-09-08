@echo off

verify >nul
dir %windir%\system32\config\systemprofile >nul 2>nul
if errorlevel 1 (
	echo User
) else (
	echo Admin
)
pause