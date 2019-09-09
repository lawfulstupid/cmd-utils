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

if ".%~1"=="./?" goto help
goto parse

:help
@REM echo FX [text] [/R] [/FG color] [/BG color] [/U ^| /-U] [/I ^| /-I]
echo FX [text] [/R] [/FG color] [/BG color] [/U] [/I]
echo Outputs text with given attributes or sets attributes globally if no text given.
echo    /R		Removes all text effects and sets default colors.
echo    /FG color	Sets foreground color (see below).
echo    /BG color	Sets background color (see below).
echo    /U		Underlining.
@REM echo    /-U		No underlining.
echo    /I		Inverted colors.
@REM echo    /-I		Non-inverted colors.
echo.
echo Colors:
echo    default	Uses default command prompt color.
@REM echo    auto		Picks between black or white based on other color.
echo    (r,g,b)	Pick color by RGB value, range from 0 to 255.
for %%C in (black gray ) do (
	call %~0 %%C /bg %%C /fg white
)
for %%C in (lightgray white red orange yellow lime green turquoise cyan lightblue blue purple magenta pink) do (
	call %~0 %%C /bg %%C /fg black
)
goto:eof

:parse
set reset=
set text=
set fg=
set bg=
set underline=
set invert=

:parseLoop
if ".%~1"=="." goto parseLoopEnd
set arg=%~1

if not "%arg:~0,1%"=="/" (
	if defined text goto argError
	set "text=%~1"
)

if /I "%arg:~1%"=="R"	set reset=%fx_reset%
if /I "%arg:~1%"=="U"	set /a underline=%fx_underline%
@REM if /I "%arg:~1%"=="-U"	set /a underline=%fx_underline%+20
if /I "%arg:~1%"=="I"	set /a invert=%fx_invert%
@REM if /I "%arg:~1%"=="-I"	set /a invert=%fx_invert%+20
if /I "%arg:~1%"=="FG" (
	call:parseColor fg %~2
	if not defined fg goto argError
	shift /2
)
if /I "%arg:~1%"=="BG" (
	call:parseColor bg %~2
	if not defined bg goto argError
	shift /2
)

shift /1
goto parseLoop
:parseLoopEnd

for %%V in (reset fg bg underline invert) do (
	if defined %%V (
		call putstr [!%%V!m
	)
)
call putstr %text%
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
set badarg=%~1
if /I "%~1"=="/FG" set badarg=%1 %2
if /I "%~1"=="/BG" set badarg=%1 %2
echo ERROR: Argument '%badarg%' not recognised!
goto:eof