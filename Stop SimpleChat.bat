@echo off
title Stop SimpleChat
echo ===================================================
echo             Stopping SimpleChat Services
echo ===================================================
echo.

echo Freeing Port 5000 (Backend)...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :5000 ^| findstr LISTENING') do (
    taskkill /f /pid %%a >nul 2>&1
)

echo Freeing Port 5173 (Frontend)...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :5173 ^| findstr LISTENING') do (
    taskkill /f /pid %%a >nul 2>&1
)

echo.
echo All SimpleChat servers have been terminated.
echo.
timeout /t 2 /nobreak >nul
