@REM TODO: automatically determine GHC version
@REM Check behaviour of `stack ghc -- --version` later
@echo off

@REM Directory to start GHCi in:
set "hsdir=%USERPROFILE%\hs"
@REM Location of ghc.exe:
set "ghc=C:\Program Files\Haskell Stack\programs\x86_64-windows\ghc-8.6.5\bin\ghc.exe"

title GHCi
set "olddir=%cd%"
cd "%hsdir%"
stack ghci
cd "%olddir%"