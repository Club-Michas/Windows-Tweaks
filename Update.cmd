@echo off
COLOR 0A
:: --- Self-elevate to admin ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
echo === Searching for App Updates ===
winget upgrade --all

echo === Updating complete ===
pause
