@echo off
:: Wake-on-LAN + Power Control Launcher
:: Autor: ChatGPT

echo Iniciando script PowerShell...
powershell -NoProfile -ExecutionPolicy Bypass -File "wol_control.ps1"

pause
