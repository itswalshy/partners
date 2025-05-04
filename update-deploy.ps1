# PowerShell script to update and deploy to GitHub Pages
$ErrorActionPreference = "Stop"

Write-Host "Starting update and deploy process..." -ForegroundColor Green

try {
    Write-Host "Pulling latest changes from GitHub..." -ForegroundColor Cyan
    git pull origin main
    if ($LASTEXITCODE -ne 0) { throw "Git pull failed" }

    Write-Host "Installing dependencies..." -ForegroundColor Cyan
    npm install --legacy-peer-deps
    if ($LASTEXITCODE -ne 0) { throw "npm install failed" }

    Write-Host "Building project..." -ForegroundColor Cyan
    $env:GEMINI_API_KEY = "AIzaSyCi_m_KbY-a36tvHl09C1Mtyx_K38GuokY"
    npm run build
    if ($LASTEXITCODE -ne 0) { throw "npm build failed" }

    Write-Host "Deploying to GitHub Pages..." -ForegroundColor Cyan
    npm run deploy
    if ($LASTEXITCODE -ne 0) { throw "npm deploy failed" }

    Write-Host "Update and deploy completed successfully!" -ForegroundColor Green
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
    Write-Host "Update and deploy process failed." -ForegroundColor Red
}

Write-Host "Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") 