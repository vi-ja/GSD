# PowerShell script to download and extract toonight/get-shit-done-for-antigravity
$repoUrl = "https://codeload.github.com/toonight/get-shit-done-for-antigravity/zip/refs/heads/main"
$zipFile = "main.zip"
$extractFolder = "get-shit-done-for-antigravity-main"

Write-Host "Downloading get-shit-done-for-antigravity..." -ForegroundColor Cyan
Invoke-WebRequest -Uri $repoUrl -OutFile $zipFile

Write-Host "Extracting files..." -ForegroundColor Cyan
Expand-Archive -Path $zipFile -DestinationPath "." -Force

Write-Host "Moving files to root folder..." -ForegroundColor Cyan
# Get all files and folders including hidden ones (excluding zip and extractFolder itself)
Get-ChildItem -Path $extractFolder -Force | ForEach-Object {
    $dest = Join-Path "." $_.Name
    if (Test-Path $dest) {
        Remove-Item $dest -Recurse -Force
    }
    Move-Item $_.FullName -Destination "." -Force
}

Write-Host "Cleaning up temporary files..." -ForegroundColor Cyan
Remove-Item $zipFile -Force
Remove-Item $extractFolder -Recurse -Force

Write-Host "Successfully loaded all repository files!" -ForegroundColor Green
