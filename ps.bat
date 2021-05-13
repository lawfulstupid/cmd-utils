@echo off
call fx /BG:1:36:86
chcp 437 >nul
powershell %*
call fx /BG:black
goto:eof