@echo off
title SimpleChat Runner
echo ===================================================
echo           Starting SimpleChat Application
echo ===================================================
echo.

cd /d "%~dp0"

echo [1/3] Starting Backend Server (Port 5000)...
start "SimpleChat Backend (Port 5000)" cmd /k "cd server && npm start"

echo [2/3] Starting Frontend Client (Port 5173)...
start "SimpleChat Frontend (Port 5173)" cmd /k "cd client && npm run dev"

echo [3/3] Waiting for services to initialize...
timeout /t 3 /nobreak >nul

echo Launching SimpleChat in your default web browser...
start http://localhost:5173

echo.
echo ===================================================
echo SimpleChat is now active!
echo Web App: http://localhost:5173
echo Backend: http://localhost:5000
echo.
echo (You can minimize this window. Close the opened terminal windows to stop the servers)
echo ===================================================
pause
