@echo off
:: Nome do script PowerShell
set ScriptPath=%~dp0instalar_apps_winget.ps1

:: Verifica se o script existe
if not exist "%ScriptPath%" (
    echo Script %ScriptPath% nao encontrado!
    pause
    exit /b
)

:: Executa o PowerShell como administrador e roda o script
powershell -NoProfile -ExecutionPolicy Bypass -Command "Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"%ScriptPath%\"' -Verb RunAs"

pause
