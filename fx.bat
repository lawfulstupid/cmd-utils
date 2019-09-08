@echo off

REM FX [bold] [attr]
REM Sets colors from this point onward.

set reset=0
set bright=1
set underline=4
set nounderline=24
set negative=7
set positive=27

set fgmod=30
set bgmod=40
set fgbmod=90
set bgbmod=100

set black=0
set red=1
set green=2
set yellow=3
set blue=4
set magenta=5
set cyan=6
set white=7
set extended=8
set default=9

@REM 38;2;r;g;b sets FG to (r,g,b)
@REM each param between 0 and FF

set code=[

@REM echo %code%%~1m

putstr %code%%~1m
@REM echo | set /p dummy=bar