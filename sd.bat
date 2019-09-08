@echo off

REM Help dialogue
if "%~1"=="/?" (
	echo Swaps the current drive while maintaining path.
	echo.
	echo SD [[/S] [/Q] files]
	echo.
	echo		files	Specifies the file^(s^) to be swapped.
	echo		/S	Recursive mode: copy subdirectories.
	echo		/Q	Quiet mode: do not prompt for confirmation.
	goto:eof
)

REM New path calculation
set cdr=%cd:~0,3%
set pth=%cd:~3%
if "%cdr%"=="C:\" (
	set ndr=B:\
) else if "%cdr%"=="B:\" (
	set ndr=C:\
) else (
	echo Unrecognised drive letter!
	pause
	goto:eof
)
set nd=%ndr%%pth%

REM Error
if not exist "%nd%" (
	echo Alternate directory does not exist.
	choice /m "Do you want to create it?" /n
	if errorlevel 2 goto:eof
	mkdir "%nd%"
)

cd /d %nd%