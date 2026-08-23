# PowerShell script to initialize git and connect to the user's repository
$remoteUrl = "https://github.com/vi-ja/GSD.git"

Write-Host "Initializing git repository..." -ForegroundColor Cyan
git init

Write-Host "Adding files to staging..." -ForegroundColor Cyan
git add .

Write-Host "Creating initial commit..." -ForegroundColor Cyan
git commit -m "Initial commit: Set up Get Shit Done for Antigravity"

Write-Host "Renaming branch to main..." -ForegroundColor Cyan
git branch -M main

Write-Host "Adding remote origin ($remoteUrl)..." -ForegroundColor Cyan
# If origin already exists, redefine it
if (git remote) {
    git remote remove origin
}
git remote add origin $remoteUrl

Write-Host "Removing installer scripts..." -ForegroundColor Cyan
if (Test-Path "download.ps1") {
    Remove-Item "download.ps1" -Force
}

# Self-deletion flag
$scriptPath = $MyInvocation.MyCommand.Path

Write-Host "--------------------------------------------------------" -ForegroundColor Yellow
Write-Host "Ready to push! Please run the following command next:" -ForegroundColor Green
Write-Host "git push -u origin main" -ForegroundColor Green
Write-Host "--------------------------------------------------------" -ForegroundColor Yellow

# Clean up this setup script
if (Test-Path $scriptPath) {
    Remove-Item $scriptPath -Force
}
