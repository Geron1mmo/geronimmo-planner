@echo off
chcp 65001 > nul
title Geronimmo Planner
set "PROJECT=D:\Geronimmo_Planner"
set "PORTABLE=%PROJECT%\executables\windows\Geronimmo_Planner\geronimmo_planner.exe"
set "BUILT=%PROJECT%\build\windows\x64\runner\Release\geronimmo_planner.exe"

cd /d "%PROJECT%"

if exist "%PORTABLE%" (
  echo Starting Geronimmo Planner...
  start "" "%PORTABLE%"
  exit /b 0
)

if exist "%BUILT%" (
  echo Starting Geronimmo Planner...
  start "" "%BUILT%"
  exit /b 0
)

echo Building Geronimmo Planner for the first time...
set "FLUTTER=%PROJECT%\flutter\bin\flutter.bat"
set "VCVARS=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"

if not exist "%FLUTTER%" (
  echo ERROR: Flutter not found at %FLUTTER%
  pause
  exit /b 1
)

call "%FLUTTER%" pub get
if exist "%VCVARS%" call "%VCVARS%" >nul 2>&1
call "%FLUTTER%" build windows --release

if exist "%BUILT%" (
  start "" "%BUILT%"
) else (
  echo Build failed. Run: flutter doctor
  pause
)
exit /b 0