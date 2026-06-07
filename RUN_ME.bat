@echo off
echo Geronimmo Planner - One-click build and run for Windows
echo.

cd /d "%~dp0"

echo Checking for Flutter at D:\Geronimmo_Planner\flutter...
if exist "D:\Geronimmo_Planner\flutter\bin\flutter.bat" (
    set "PATH=D:\Geronimmo_Planner\flutter\bin;%PATH%"
    echo Flutter found and added to PATH.
) else (
    echo Flutter not found at D:\Geronimmo_Planner\flutter.
    echo Please wait for the download to finish or install Flutter manually.
    echo Then run this file again.
    pause
    exit /b
)

echo.
echo Building for all platforms and launching Windows version...
powershell -ExecutionPolicy Bypass -File "build_and_run.ps1"

echo.
echo If the program didn't launch, check the output above.
pause
