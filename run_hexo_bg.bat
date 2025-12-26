@echo off
cd /d "%~dp0"
echo Looking for processes using port 4000...
setlocal enabledelayedexpansion
set "found=0"
for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":4000"') do (
  set "found=1"
  echo Killing PID %%a...
  taskkill /PID %%a /F >nul 2>&1
)
if "!found!"=="0" echo No process found on port 4000.
echo Starting hexo commands in background (logs -> hexo_server.log)...
start "" /B cmd /c "hexo clean && hexo g && hexo s "
echo Done.
