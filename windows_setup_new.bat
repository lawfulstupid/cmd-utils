@echo off

@REM Set Notepad++ to open files with no extension
echo Enter path to notepad++.exe
set /p editorPath=
assoc .="No_Extension"
ftype "No_Extension"=%editorPath% "%1"

