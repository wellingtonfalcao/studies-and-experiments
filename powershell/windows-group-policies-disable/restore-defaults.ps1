# Requer execução como administrador
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process PowerShell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Write-Host "Restaurando configurações padrão do Windows..."

# Lista de chaves que foram modificadas e serão removidas
$registryPaths = @(
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Application Compatibility",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\TabletPC",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\AdvertisingInfo",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization",
    "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main",
    "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\TabPreloader",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\SettingSync",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
)

# Remover cada chave (isso remove as políticas e permite que o padrão do Windows seja usado)
foreach ($path in $registryPaths) {
    if (Test-Path $path) {
        Remove-Item -Path $path -Recurse -Force
        Write-Host "Removido: $path"
    }
}

Write-Host "`nRestauração concluída. As configurações padrão do Windows serão aplicadas."
Write-Host "Reinicie o computador para que as alterações tenham efeito completo." -ForegroundColor Yellow