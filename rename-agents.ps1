# PowerShell script to rename GSD subagent files and push changes
$agentsDir = ".agents/agents"

Write-Host "Renaming subagent files..." -ForegroundColor Cyan

$subagents = @("debugger", "executor", "planner", "researcher", "verifier")

foreach ($agent in $subagents) {
    $oldPath = Join-Path $agentsDir "gsd-$agent.md"
    $newPath = Join-Path $agentsDir "devflow-$agent.md"
    
    if (Test-Path $oldPath) {
        Rename-Item -Path $oldPath -NewName "devflow-$agent.md" -Force
        Write-Host "Renamed gsd-$agent.md -> devflow-$agent.md" -ForegroundColor Green
    } else {
        Write-Host "File $oldPath not found (already renamed?)" -ForegroundColor Gray
    }
}

Write-Host "Staging changes to Git..." -ForegroundColor Cyan
git add --all

Write-Host "Committing file renames..." -ForegroundColor Cyan
git commit -m "refactor: rename subagent files from gsd to devflow"

Write-Host "Pushing fixes to GitHub..." -ForegroundColor Cyan
git push

Write-Host "Re-running validation checks..." -ForegroundColor Cyan
Powershell -ExecutionPolicy Bypass -File .\scripts\validate-all.ps1

# Self-delete the script
$scriptPath = $MyInvocation.MyCommand.Path
if (Test-Path $scriptPath) {
    Remove-Item $scriptPath -Force
}
