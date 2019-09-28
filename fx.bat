@echo off
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
set c_turquoise=96
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
echo FX [text] [/R] [/FG:color] [/BG:color] [/U] [/I]
echo Outputs text with given attributes or sets attributes globally if no text given.
echo    /R	Removes all text effects and sets default colors.
echo    /U	Underlining.
echo    /I	Inverted colors.
echo    /FG	Sets foreground color (see below).
echo    /BG	Sets background color (see below).
echo.
echo Colors:
echo    default	Uses default command prompt color.
@REM echo    auto		Picks between black or white based on other color. (WIP)
@REM echo    (r,g,b)	Pick color by RGB value, range from 0 to 255. (WIP)
for %%C in (white lightgray) do (
	call putstr "   "
	call %~0 %%C /bg:%%C /fg:black
	echo.
)
for %%C in (gray black blue) do (
	call putstr "   "
	call %~0 %%C /bg:%%C /fg:white
	echo.
)
for %%C in (lightblue cyan turquoise green lime yellow orange red pink magenta purple) do (
	call putstr "   "
	call %~0 %%C /bg:%%C /fg:black
	echo.
)
goto:eof

:parseArgs
set reset=
set text=
set fg=
set bg=
set underline=
set invert=

for %%A in (%*) do (
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
	) else (
		goto argError %%A
	)
)

for %%V in (reset fg bg underline invert) do (
	if defined %%V (
		call putstr [!%%V!m
	)
)
call putstr "%text%"
call putstr [0m
goto:eof

:parseColor
set arg2=%~2
if "%arg2:~0,1%"=="(" (
	call:parseRGB %~1 %~2
	goto:eof
)

@REM TODO: Handle 'auto'
@REM if "%arg2%"=="auto" (
	@REM if "%~1"=="fg" set other=bg
	@REM if "%~1"=="bg" set other=fg
@REM )

for %%P in (default black gray lightgray white red orange yellow lime green turquoise cyan lightblue blue purple magenta pink) do (
	if /I "%~2"=="%%P" set %~1=!c_%%P!
)
if defined %~1 for /f %%N in ('echo !%~1!') do set %~1=%%N
if "%~1"=="bg" if defined bg set /a bg=!bg!+10
goto:eof

:parseRGB
@REM TODO
goto:eof

:argError
echo ERROR: Argument '%~1' not recognised!
exit /b 1