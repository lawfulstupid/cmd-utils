@echo off
del /f /s /q "%~1" >nul
rmdir /s /q "%~1" 2>nul