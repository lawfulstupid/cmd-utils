@REM The following registry key needs to point to this file:
@REM "HKCU\Software\Microsoft\Command Processor\AutoRun".
@REM Create if does not exist, AutoRun is type String.
@echo off

@REM UTF-8 code page
@chcp 65001 >nul

@REM trailing space on following line is intentional - leave it be
prompt $P$_$G$G$G 
echo Thank you for helping us help you help us all.

set "macro=."
set "command=cd ."

@REM "ups" i.e. '..' -> 'cd ..'
setlocal EnableDelayedExpansion
for /l %%I in (0,1,10) do (
	doskey !macro!=!command!
   set macro=!macro!.
   set command=!command!\..
)
setlocal DisableDelayedExpansion

doskey x=exit
doskey q=exit
doskey home=cd %USERPROFILE%
doskey edit="C:\Program Files\Notepad++\notepad++.exe" $*
doskey ps=powershell $*
doskey brb=shutdown /r /t 0
doskey sda=shutdown /a

@echo on