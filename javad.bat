@echo off
if ".%~1"=="/full" (
   set dir=%cd%
   if exist "%~1" set dir=%~1
   for /d %%D in (* .) do (
      call %~0 "%%~D"\*.class -o "%%~D"
   )
) else (
   java -jar C:\Users\Alex\bin\procyon-decompiler-0.5.30.jar %*
)
