@echo off
echo Starting update and deploy process...

echo Pulling latest changes from GitHub...
git pull origin main

echo Installing dependencies...
npm install --legacy-peer-deps

echo Building project...
set GEMINI_API_KEY=AIzaSyCi_m_KbY-a36tvHl09C1Mtyx_K38GuokY
npm run build

echo Deploying to GitHub Pages...
npm run deploy

echo Update and deploy completed!
pause 