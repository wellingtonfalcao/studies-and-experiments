# Requer execução como administrador
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process PowerShell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
New-Item -Path $registryPath -Force | Out-Null
Set-ItemProperty -Path $registryPath -Name "AllowTelemetry" -Value 0 -Type DWord

# Telemetria e Diagnóstico
@(
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Application Compatibility",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\TabletPC",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\AdvertisingInfo",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization",
    "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main",
    "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\TabPreloader"
) | ForEach-Object { New-Item -Path $_ -Force | Out-Null }

# Configurações de Telemetria e Compatibilidade
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "AITEnable" -Value 0 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableInventory" -Value 1 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Application Compatibility" -Name "DisableProgramInventory" -Value 1 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Application Compatibility" -Name "DisableSwitchBack" -Value 1 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\TabletPC" -Name "DisableDiagnostics" -Value 1 -Type DWord

# Conteúdo na Nuvem e Dicas
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Value 1 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableSoftLanding" -Value 1 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableThirdPartySuggestions" -Value 1 -Type DWord

# Localização e Sensores
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocation" -Value 1 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableSensors" -Value 1 -Type DWord

# Atualizações Automáticas
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "NoAutoUpdate" -Value 0 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "AUOptions" -Value 2 -Type DWord

# Microsoft Edge
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Main" -Name "AllowPrelaunch" -Value 0 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\TabPreloader" -Name "AllowTabPreloading" -Value 0 -Type DWord

# Cortana e Pesquisa
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Value 0 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Value 1 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "ConnectedSearchUseWeb" -Value 0 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowSearchToUseLocation" -Value 0 -Type DWord

# Aplicativos em Segundo Plano
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsRunInBackground" -Value 2 -Type DWord

# Relatórios de Erro
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value 1 -Type DWord

# Sincronização de Configurações
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\SettingSync" -Name "DisableCredentialsSettingSync" -Value 2 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\SettingSync" -Name "DisableApplicationSettingSync" -Value 2 -Type DWord

# Histórico de Documentos
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Value 0 -Type DWord

# ID de Publicidade
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Value 1 -Type DWord

# Feed de Atividades
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Value 0 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Value 0 -Type DWord

Write-Host "Configurações aplicadas com sucesso!"