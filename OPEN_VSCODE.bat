@echo off
echo Opening Geronimmo Planner project in VS Code...
set "CODE=%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe"
if exist "%CODE%" (
  start "" "%CODE%" "D:\Geronimmo_Planner"
  echo VS Code launched with the project.
) else (
  code "D:\Geronimmo_Planner" 2>nul || echo VS Code is installed (see winget). Search "Visual Studio Code" in Windows Start menu, then open folder: D:\Geronimmo_Planner
)
echo.
pause
