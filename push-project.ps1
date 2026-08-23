# PowerShell script to push to user's Git repository
$remoteUrl = "https://github.com/vi-ja/GSD.git"

# Check if git is initialized
if (!(Test-Path ".git")) {
    Write-Host "Initializing local git repository..." -ForegroundColor Cyan
    git init
} else {
    Write-Host "Git is already initialized locally." -ForegroundColor Gray
}

Write-Host "Staging all files..." -ForegroundColor Cyan
git add --all

Write-Host "Creating commit..." -ForegroundColor Cyan
git commit -m "Initial commit: Setup customized DevFlow framework"

Write-Host "Setting default branch to main..." -ForegroundColor Cyan
git branch -M main

Write-Host "Connecting remote origin to $remoteUrl..." -ForegroundColor Cyan
# Check if remote origin already exists
$existingRemotes = git remote
if ($existingRemotes -contains "origin") {
    git remote set-url origin $remoteUrl
} else {
    git remote add origin $remoteUrl
}

Write-Host "Pushing files to main branch on GitHub..." -ForegroundColor Cyan
Write-Host "Note: If your remote repository is new but has initialization files (like README/License), we will use force-push to set up clean." -ForegroundColor Yellow
git push -u origin main --force

Write-Host "Push complete!" -ForegroundColor Green

# Self-delete the push script to keep workspace clean
$scriptPath = $MyInvocation.MyCommand.Path
if (Test-Path $scriptPath) {
    Remove-Item $scriptPath -Force
}
