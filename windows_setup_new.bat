@echo off

@REM Set Notepad++ to open files with no extension
echo Enter path to notepad++.exe
set /p editorPath=
assoc .="No_Extension"
ftype "No_Extension"=%editorPath% "%1"

@REM Set up init.bat
reg add "HKCU\Software\Microsoft\Command Processor" /v "AutoRun" /d "%~dp0init.bat"

@REM Remove "OneDrive" link in Windows Explorer
reg add "HKCR\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /v "System.IsPinnedToNameSpaceTree" /d 0

@REM Remove "3D Objects" folder
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f

@REM Remove "Edit with Photos" context action
reg add "HKCR\AppX43hnxtbyyps62jhe9sqpdzxn1790zetc\Shell\ShellEdit" /v "ProgrammaticAccessOnly"

@REM Remove "Edit with Paint 3D" context action
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.jpg\Shell\3D Edit" /f
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.jpeg\Shell\3D Edit" /f
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.png\Shell\3D Edit" /f
reg delete "HKLM\SOFTWARE\Classes\SystemFileAssociations\.gif\Shell\3D Edit" /f