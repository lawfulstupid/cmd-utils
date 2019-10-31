@REM TODO: automatically determine GHC version
@REM Check behaviour of `stack ghc -- --version` later
@echo off

@REM Directory to start GHCi in:
set "hsdir=%USERPROFILE%\hs"
@REM Location of ghc.exe:
set "ghc=%STACK_ROOT%\programs\x86_64-windows\ghc-8.6.5\bin\ghc.exe"

title GHCi
set "olddir=%cd%"
cd "%hsdir%"

@REM One of these
@REM "%ghc%" --interactive %*
@REM start /b /wait stack repl
stack ghci

cd "%olddir%"
