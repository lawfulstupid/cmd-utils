@echo off
setlocal enabledelayedexpansion

REM Settings
set verbose=0
set games=SkyrimSE,FalloutNV

REM Instructions
set kills=0
for %%E in (%games%) do (
	taskkill /f /fi "imagename eq %%E.exe" | find "SUCCESS" > nul
	if /I !errorlevel! EQU 0 (
		if %verbose%==1 echo Process "%%E.exe" killed.
		set /a kills=!kills!+1
	)
)

set pword=processes
if /I %kills% EQU 1 set pword=process
echo %kills% %pword% killed.