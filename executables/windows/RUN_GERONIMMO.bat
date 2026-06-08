@echo off
chcp 65001 > nul
title Geronimmo Planner - Ready to Run (auto fixes toolchain)
echo ============================================
echo   Geronimmo Planner - One click launcher
echo   (Does everything: pub get, vcvars, build, launch)
echo ============================================
echo.

set "PROJECT=D:\Geronimmo_Planner"
set "FLUTTER=%PROJECT%\flutter\bin\flutter.bat"
set "VCVARS=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
set "EXE=%PROJECT%\build\windows\x64\runner\Release\geronimmo_planner.exe"

cd /d "%PROJECT%"

echo [1/5] Checking Flutter...
if not exist "%FLUTTER%" (
  echo ERROR: Flutter not at %FLUTTER%
  pause
  exit /b 1
)

echo [2/5] Running flutter pub get (safe in project root)...
call "%FLUTTER%" pub get

echo [3/5] Activating Visual C++ toolchain (vcvars64)...
if exist "%VCVARS%" (
  call "%VCVARS%" >nul 2>&1
  echo Toolchain activated (cl.exe should be available).
) else (
  echo WARNING: vcvars not found at expected path, build may fail if C++ tools missing.
)

echo [4/5] Building Windows release (this takes a few minutes first time)...
call "%FLUTTER%" build windows --release

echo [5/5] Launching...
if exist "%EXE%" (
  echo SUCCESS: Found exe at %EXE%
  echo Starting Geronimmo Planner now...
  start "" "%EXE%"
  echo.
  echo If it opened - great! You can also double-click the exe directly next time.
  echo Portable copy also in: executables\windows\
  timeout /t 5 >nul
) else (
  echo.
  echo Build did not produce exe. Common: run the VS Installer "Modify" and add "Desktop development with C++".
  echo Then re-run this bat.
  echo.
  echo Alternative: Open the folder in VS Code (code D:\Geronimmo_Planner) and press F5 or use Tasks: Build Windows EXE.
  pause
)

echo Done.
exit /b 0
