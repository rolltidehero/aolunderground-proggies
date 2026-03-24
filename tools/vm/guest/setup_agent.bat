@echo off
echo === Setting up guest agent ===

if not exist C:\Tools mkdir C:\Tools
copy /Y "%~dp0agent.py" C:\Tools\agent.py

REM Create scheduled task to run at logon
schtasks /create /tn "AnalysisAgent" /tr "pythonw.exe C:\Tools\agent.py" /sc onlogon /rl highest /f

echo === Agent installed. Will start on next logon. ===
echo Starting agent now...
start "" pythonw.exe C:\Tools\agent.py
pause
