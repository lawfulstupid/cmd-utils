@echo off

@REM To use exclamation marks, quote the string.
@REM No idea why that's necessary.
set allArgs=%*
set allArgs=%allArgs:!=^^^!%

setlocal EnableDelayedExpansion

set fx_reset=0
set fx_underline=4
set fx_invert=7

set c_default=39
set c_black=30
set c_gray=90
set c_lightgray=37
set c_white=97
set c_red=31
set c_orange=33
set c_yellow=93
set c_lime=92
set c_green=32
set c_teal=96
set c_cyan=36
set c_lightblue=94
set c_blue=34
set c_purple=35
set c_magenta=95
set c_pink=91
set c_RGB=38

goto parseArgs

:help
@REM echo FX [text] [/R] [/U] [/I] [/FG color] [/BG color]
echo FX [text] [/R] [/FG:color] [/BG:color] [/U] [/I] [/N]
echo Outputs text with given attributes or sets attributes globally if no text given.
echo    /R	Removes all text effects and sets default colors.
echo    /U	Underlining.
echo    /I	Inverted colors.
echo    /FG	Sets foreground color (see below).
echo    /BG	Sets background color (see below).
echo	/N	End text with new line.
echo.
echo Colors:
echo    default	Uses default command prompt color.
echo    auto		Picks between black or white based on other color.
echo    (r,g,b)	Pick color by RGB value, range from 0 to 255. (WIP)

for %%C in (white lightgray gray black blue lightblue cyan teal green lime yellow orange red pink magenta purple) do (
	call putstr "   "
	call %0 %%C /bg:%%C /fg:auto /n
)
goto:eof

:parseArgs
set reset=
set text=
set fg=
set bg=
set underline=
set invert=
set newline=

for %%A in (%allArgs%) do (
	set "arg=%%~A"
	if not "!arg:~0,1!"=="/" (
		@REM If not flag
		if defined text goto argError %%A
		set "text=%%~A"
	) else if /I "!arg!"=="/?" (
		goto help
	) else if /I "!arg!"=="/H" (
		goto help
	) else if /I "!arg!"=="/R" (
		set reset=%fx_reset%
	) else if /I "!arg!"=="/U" (
		set underline=%fx_underline%
	) else if /I "!arg!"=="/I" (
		set invert=%fx_invert%
	) else if /I "!arg:~,3!"=="/FG" (
		call:parseColor fg !arg:~4!
		if not defined fg goto argError %%A
	) else if /I "!arg:~,3!"=="/BG" (
		call:parseColor bg !arg:~4!
		if not defined bg goto argError %%A
	) else if /I "!arg!"=="/N" (
		set newline=1
	) else (
		goto argError %%A
	)
)

for %%V in (reset fg bg underline invert) do (
	if defined %%V (
		call putstr [!%%V!m
	)
)
@REM Can't call putstr because of exclamation marks
@echo | set /p dummy=7!text!
if defined text call putstr [0m
if defined newline echo;
goto:eof

@REM :parseColor (FG | BG) COLOR
:parseColor
set col=%~2

if "%col%"=="auto" (
	call:autoColor %~1
	goto:eof
)

if "%col:~0,1%"=="(" (
	call:parseRGB %~1 %~2
	goto:eof
)

for %%P in (default black gray lightgray white red orange yellow lime green teal cyan lightblue blue purple magenta pink) do (
	if /I "%col%"=="%%P" set %~1=!c_%%P!
)
if defined %~1 for /f %%N in ('echo !%~1!') do set %~1=%%N
if "%~1"=="bg" if defined bg set /a bg=!bg!+10
goto:eof

:autoColor
if "%~1"=="fg" set /a other=%bg%-10
if "%~1"=="bg" set other=%fg%
set %~1=%c_black%
for %%C in (gray black blue purple red pink magenta) do (
	if /I "!other!"=="!c_%%C!" set %~1=%c_white%
)
goto:eof

:parseRGB
@REM TODO
goto:eof

:argError
echo ERROR: Argument '%~1' not recognised!
exit /b 1