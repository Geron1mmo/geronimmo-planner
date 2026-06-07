@echo off
chcp 65001 > nul
title Geronimmo Planner Launcher

set FLUTTER=D:\Geronimmo_Planner\flutter\bin\flutter.bat
cd /d "%~dp0"

if not exist "%FLUTTER%" (
    echo Flutter not found at %FLUTTER%
    echo Please make sure Flutter is extracted to D:\Geronimmo_Planner\flutter
    pause
    exit /b
)

echo Generating platforms and building...
call "%FLUTTER%" create . --platforms=windows,android,ios --project-name geronimmo_planner
call "%FLUTTER%" pub get
call "%FLUTTER%" build windows --release

set EXE=build\windows\x64\runner\Release\geronimmo_planner.exe
if exist "%EXE%" (
    echo Launching Geronimmo Planner...
    start "" "%EXE%"
) else (
    echo Build failed. Check above for errors (you may need Visual Studio C++ tools).
    pause
)
