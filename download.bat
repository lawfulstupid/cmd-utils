@echo off
REM download url dest
REM Saves the file in the url at the given destination
powershell -Command "(New-Object Net.WebClient).DownloadFile('%~1', '%~2')"
goto:eof