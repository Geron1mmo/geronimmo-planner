# Auto launcher for Geronimmo Planner
# This will wait for Flutter if needed, then build and launch the app

$flutterExe = "D:\Geronimmo_Planner\flutter\bin\flutter.bat"
$projectDir = $PSScriptRoot

Write-Host "Geronimmo Planner Auto Launcher"
Write-Host "Waiting for Flutter to be ready..."

$maxWait = 30 # minutes
$waited = 0
$interval = 30 # seconds

while ($waited -lt ($maxWait * 60)) {
    if (Test-Path $flutterExe) {
        Write-Host "Flutter found! Starting build..."
        break
    }
    Start-Sleep -Seconds $interval
    $waited += $interval
    Write-Host "Still waiting for Flutter... ($waited seconds)"
}

if (-not (Test-Path $flutterExe)) {
    Write-Host "Flutter not found after waiting. Please install Flutter manually to D:\flutter"
    Read-Host "Press Enter to exit"
    exit
}

# Set path
$env:Path = "D:\Geronimmo_Planner\flutter\bin;$env:Path"

Set-Location $projectDir

Write-Host "Generating platform folders (Windows, Android, iOS)..."
& $flutterExe create . --platforms=windows,android,ios

Write-Host "Getting dependencies..."
& $flutterExe pub get

Write-Host "Building Windows executable..."
& $flutterExe build windows --release

$exePath = "build\windows\x64\runner\Release\geronimmo_planner.exe"

if (Test-Path $exePath) {
    Write-Host "Build successful! Launching Geronimmo Planner..."
    Start-Process -FilePath (Resolve-Path $exePath)
    Write-Host "App is now running!"
} else {
    Write-Host "Build failed. Check output above."
    Read-Host "Press Enter to close"
}
