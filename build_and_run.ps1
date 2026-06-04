# Geronimmo Planner - Build and Run Script for Windows
# Run this after Flutter is installed.

$flutterBin = "D:\flutter\bin"
if (Test-Path $flutterBin) {
    $env:Path = "$flutterBin;$env:Path"
    Write-Host "Flutter added to PATH for this session."
} else {
    Write-Host "Flutter not found at D:\flutter. Please install it first."
    exit 1
}

Write-Host "Changing to project directory..."
Set-Location $PSScriptRoot

Write-Host "Running flutter create for all platforms..."
flutter create . --platforms=windows,android,ios

Write-Host "Getting dependencies..."
flutter pub get

Write-Host "Building Windows executable (release)..."
flutter build windows --release

$exePath = "build\windows\x64\runner\Release\geronimmo_planner.exe"

if (Test-Path $exePath) {
    Write-Host "Build successful! Executable at: $exePath"
    Write-Host "Launching the program..."
    Start-Process -FilePath $exePath
    Write-Host "Geronimmo Planner is now running!"
} else {
    Write-Host "Build failed. Check the output above."
    Write-Host "Common issues: Run 'flutter doctor' to check setup."
}

Write-Host "For Android APK: flutter build apk --release"
Write-Host "For iOS (requires Mac): flutter build ios --release"
