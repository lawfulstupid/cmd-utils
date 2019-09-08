@echo off

set dir=%cd%
if exist "%~1" set dir=%~1

for /d %%D in (* .) do (
	call javad "%%~D"\*.class -o "%%~D"
)