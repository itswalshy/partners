# Setup scheduled task for automatic updates
$taskName = "TipJarGitHubPagesAutoUpdate"
$scriptPath = Join-Path -Path $PWD.Path -ChildPath "update-deploy.ps1"
$workingDir = $PWD.Path

# Create the scheduled task action
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -WorkingDirectory $workingDir

# Create trigger (adjust as needed - this runs daily at 9 AM)
$trigger = New-ScheduledTaskTrigger -Daily -At 9am

# Register the task (will prompt for credentials)
Write-Host "Setting up scheduled task to run the update script daily at 9 AM..." -ForegroundColor Cyan
Write-Host "You'll need to provide administrator credentials for task creation."

try {
    Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Description "Automatically updates and deploys the TipJar GitHub Pages site" -RunLevel Highest
    Write-Host "Scheduled task '$taskName' created successfully!" -ForegroundColor Green
    Write-Host "The update script will run daily at 9 AM." -ForegroundColor Green
    Write-Host "You can modify the schedule in Task Scheduler." -ForegroundColor Green
}
catch {
    Write-Host "Error creating scheduled task: $_" -ForegroundColor Red
}

Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") 