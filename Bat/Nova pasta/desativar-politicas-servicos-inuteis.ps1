# Script modular para alterar politicas e servicos do Windows 10/11
# Backup automatico, log, menu interativo, elevacao e console permanente

# --- Garantir execucao como administrador ---
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Reiniciando como Administrador..."
    Start-Process powershell.exe "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# --- Diretorio do script e pasta Backup ---
$ScriptDir = Split-Path -Parent $PSCommandPath
$BackupDir = Join-Path $ScriptDir "Backup"
if (-not (Test-Path $BackupDir)) { New-Item -Path $BackupDir -ItemType Directory | Out-Null }

# --- Logging ---
$LogFile = Join-Path $ScriptDir "PolicyScript_Log_$(Get-Date -Format yyyyMMdd_HHmmss).txt"
function Write-Log { param([string]$msg) "$((Get-Date).ToString('HH:mm:ss')) - $msg" | Tee-Object -FilePath $LogFile -Append }

# --- Função de backup ---
function Backup-AllPolicies {
    Write-Host "`nCriando backup completo das políticas..."
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $backupFile = Join-Path $BackupDir "BackupReg_$timestamp.reg"

    $keys = @(
        "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection",
        "HKLM\SYSTEM\CurrentControlSet\Services\DiagTrack",
        "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice",
        "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search",
        "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc",
        "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore",
        "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive",
        "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager",
        "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications"
    )

    try {
        foreach ($key in $keys) {
            reg export $key $backupFile /y | Out-Null
        }
        Write-Log "Backup criado com sucesso: $backupFile"
        Write-Host "Backup salvo em: $backupFile"
    } catch {
        Write-Log "Erro ao criar backup: $_"
        Write-Host "Erro ao criar backup."
    }
    Pause
}

# --- Restaurar backup ---
function Restore-RegistryBackup {
    $files = Get-ChildItem "$BackupDir\BackupReg_*.reg" -ErrorAction SilentlyContinue
    if (-not $files) {
        Write-Host "Nenhum backup encontrado."
        return
    }

    Write-Host "`nBackups disponiveis:"
    $i = 1
    foreach ($f in $files) { Write-Host "$i) $($f.Name)"; $i++ }

    $choice = Read-Host "Escolha o número do backup para restaurar"
    if ($choice -ge 1 -and $choice -le $files.Count) {
        $file = $files[$choice-1].FullName
        try {
            reg import $file | Out-Null
            Write-Log "Backup restaurado: $file"
            Write-Host "Backup restaurado com sucesso!"
        } catch {
            Write-Log "Erro ao restaurar backup: $_"
            Write-Host "Falha ao restaurar backup."
        }
    } else {
        Write-Host "Opção inválida."
    }
    Pause
}

# --- Garante que a chave do registro exista ---
function Ensure-RegistryKey {
    param([string]$RegPath)
    if (-not (Test-Path $RegPath)) {
        New-Item -Path $RegPath -Force | Out-Null
    }
}

# --- Aplicar politicas ---
function Set-LocalPolicy {
    param([string]$PolicyName)
    switch ($PolicyName) {
        "DesativarTelemetriaApps" {
            Write-Log "Desativando Telemetria de Aplicativos..."
            $regPath="HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"
            Ensure-RegistryKey $regPath
            Set-ItemProperty -Path $regPath -Name "AllowTelemetry" -Value 0 -Type DWord -Force
        }
        "DesativarDiagTrack" {
            Stop-Service DiagTrack -Force -ErrorAction SilentlyContinue
            Set-Service DiagTrack -StartupType Disabled
        }
        "DesativarDmwappush" {
            Stop-Service dmwappushservice -Force -ErrorAction SilentlyContinue
            Set-Service dmwappushservice -StartupType Disabled
        }
        "DesativarCortana" {
            $regPath="HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search"
            Ensure-RegistryKey $regPath
            Set-ItemProperty -Path $regPath -Name "AllowCortana" -Value 0 -Type DWord -Force
        }
        "DesativarLocalizacao" {
            Stop-Service lfsvc -Force -ErrorAction SilentlyContinue
            Set-Service lfsvc -StartupType Disabled
        }
        "DesativarStoreAutoUpdate" {
            $regPath="HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore"
            Ensure-RegistryKey $regPath
            Set-ItemProperty -Path $regPath -Name "AutoDownload" -Value 2 -Type DWord -Force
        }
        "DesativarOneDriveSync" {
            $regPath="HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive"
            Ensure-RegistryKey $regPath
            Set-ItemProperty -Path $regPath -Name "DisableFileSync" -Value 1 -Type DWord -Force
        }
        "DesativarFeedbackWindows" {
            $regPath="HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"
            Ensure-RegistryKey $regPath
            Set-ItemProperty -Path $regPath -Name "SystemPaneSuggestionsEnabled" -Value 0 -Type DWord -Force
        }
        "DesativarNotificacoesDicas" {
            $regPath="HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications"
            Ensure-RegistryKey $regPath
            Set-ItemProperty -Path $regPath -Name "ToastEnabled" -Value 0 -Type DWord -Force
        }
    }
    Write-Host "Política '$PolicyName' aplicada."
    Write-Log "Política '$PolicyName' aplicada com sucesso."
}

# --- Verificação de status ---
function Check-PoliciesStatus {
    $policies=@{
        "Telemetria Apps" = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection\AllowTelemetry";
        "DiagTrack" = "HKLM:\SYSTEM\CurrentControlSet\Services\DiagTrack\Start";
        "dmwappushservice" = "HKLM:\SYSTEM\CurrentControlSet\Services\dmwappushservice\Start";
        "Cortana" = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search\AllowCortana";
        "Localizacao" = "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Start";
        "Store Auto Update" = "HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore\AutoDownload";
        "OneDrive Sync" = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive\DisableFileSync";
        "Feedback Windows" = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\SystemPaneSuggestionsEnabled";
        "Notificacoes Dicas" = "HKCU:\Software\Microsoft\Windows\CurrentVersion\PushNotifications\ToastEnabled";
    }

    $ativados = @(); $desativados=@(); $naoConfig=@()

    foreach ($key in $policies.Keys) {
        $regPath = $policies[$key]
        $status = "Nao configurado"
        if (Test-Path (Split-Path $regPath)) {
            $prop = Split-Path $regPath -Leaf
            $value = (Get-ItemProperty -Path (Split-Path $regPath) -Name $prop -ErrorAction SilentlyContinue).$prop
            if ($value -eq 0 -or $value -eq 2) { $status = "Desativado" }
            elseif ($value -eq 1) { $status = "Ativado" }
        }

        switch ($status) {
            "Ativado" { $ativados += $key }
            "Desativado" { $desativados += $key }
            default { $naoConfig += $key }
        }
    }

    Write-Host "`n===== STATUS DAS POLITICAS =====`n"
    Write-Host "Ativados:"; if ($ativados.Count -eq 0){Write-Host "- Nenhum"} else{$ativados|%{Write-Host "- $_"}}
    Write-Host "`nDesativados:"; if ($desativados.Count -eq 0){Write-Host "- Nenhum"} else{$desativados|%{Write-Host "- $_"}}
    Write-Host "`nNao configurado:"; if ($naoConfig.Count -eq 0){Write-Host "- Nenhum"} else{$naoConfig|%{Write-Host "- $_"}}
    Pause
}

# --- Menu principal ---
function Show-MainMenu {
    while ($true) {
        Clear-Host
        Write-Host "===== MENU PRINCIPAL =====`n"
        Write-Host "01) Verificar Status das Políticas"
        Write-Host "02) Desativar Políticas Individuais"
        Write-Host "03) Desativar Todas"
        Write-Host "04) Fazer Backup das Políticas"
        Write-Host "05) Restaurar Backup"
        Write-Host "00) Sair"
        $sel = Read-Host "Escolha uma opção"
        switch ($sel) {
            0 { return }
            1 { Check-PoliciesStatus }
            2 { Show-IndividualPoliciesMenu }
            3 { 1..9 | ForEach-Object { Set-LocalPolicy ("Desativar"+(("TelemetriaApps","DiagTrack","Dmwappush","Cortana","Localizacao","StoreAutoUpdate","OneDriveSync","FeedbackWindows","NotificacoesDicas")[$_-1])) }; Pause }
            4 { Backup-AllPolicies }
            5 { Restore-RegistryBackup }
            default { Write-Host "Opção inválida."; Pause }
        }
    }
}

# --- Menu individual ---
function Show-IndividualPoliciesMenu {
    $policies = @(
        "DesativarTelemetriaApps",
        "DesativarDiagTrack",
        "DesativarDmwappush",
        "DesativarCortana",
        "DesativarLocalizacao",
        "DesativarStoreAutoUpdate",
        "DesativarOneDriveSync",
        "DesativarFeedbackWindows",
        "DesativarNotificacoesDicas"
    )
    while ($true) {
        Clear-Host
        Write-Host "===== POLÍTICAS INDIVIDUAIS =====`n"
        for ($i=0; $i -lt $policies.Count; $i++) {
            Write-Host ("{0:D2}) {1}" -f ($i+1), ($policies[$i] -replace "Desativar","Desativar "))
        }
        Write-Host "00) Voltar"
        $sel = Read-Host "Escolha uma opção"
        if ($sel -eq 0) { break }
        if ($sel -ge 1 -and $sel -le $policies.Count) {
            Set-LocalPolicy $policies[$sel-1]
            Pause
        }
    }
}

# --- Execução principal ---
try {
    Show-MainMenu
} catch {
    Write-Log "ERRO inesperado: $_"
} finally {
    Write-Host "`nOperação concluída. Pressione Enter para sair..."
    Read-Host | Out-Null
}
