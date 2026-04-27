@echo off
color 0A
title Windows Repair Script

:: --- Self-elevate to admin ---
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo === Starting DISM health check ===
DISM /Online /Cleanup-Image /CheckHealth
if %errorlevel% equ 0 (
    echo No corruption detected. Skipping ScanHealth and RestoreHealth.
    goto sfc
)

echo === Scanning for component store corruption ===
DISM /Online /Cleanup-Image /ScanHealth

echo === Restoring component store health ===
DISM /Online /Cleanup-Image /RestoreHealth

:sfc
echo === Running System File Checker ===
sfc /scannow

echo === All operations completed ===
pause
