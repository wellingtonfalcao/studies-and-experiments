# ==============================================
# Script PowerShell: Instalacao via Winget com Log Incremental
# Lista de apps externa via TXT comentavel
# Para Windows 10/11 64bits
# ==============================================

# Pasta de logs
$LogFolder = "$PSScriptRoot\Logs"
if (-not (Test-Path $LogFolder)) {
    New-Item -ItemType Directory -Path $LogFolder | Out-Null
}

# Nome do arquivo de log com data e hora
$LogFile = "$LogFolder\winget_install_log_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

# Funcao para escrever log
function Write-Log {
    param (
        [string]$Message
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp - $Message"
    Add-Content -Path $LogFile -Value $logEntry
    Write-Host $Message
}

# Funcao para verificar se o winget esta instalado
function Check-Winget {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host "Winget nao encontrado. Instale o App Installer antes de prosseguir." -ForegroundColor Red
        exit
    }
}

# Funcao para verificar se o aplicativo esta instalado
function Is-AppInstalled {
    param (
        [string]$AppName
    )
    $installed = winget list --name $AppName 2>$null | Select-String $AppName
    return $installed -ne $null
}

# Carrega lista de aplicativos do TXT
$TxtPath = "$PSScriptRoot\lista-de-aplicativos.txt"
if (-not (Test-Path $TxtPath)) {
    Write-Host "Arquivo apps.txt nao encontrado!" -ForegroundColor Red
    exit
}

# Lê linhas válidas (ignora linhas vazias e comentários)
$apps = @()
Get-Content -Path $TxtPath | ForEach-Object {
    $line = $_.Trim()
    if ($line -and -not $line.StartsWith("#")) {
        $parts = $line -split ",", 2
        if ($parts.Count -eq 2) {
            $apps += [PSCustomObject]@{
                Id = $parts[0].Trim()
                Name = $parts[1].Trim()
            }
        }
    }
}

# Inicio do script
Write-Log "=== Inicio do processo de instalacao via Winget ==="

# Verifica winget
Check-Winget

# Variavel para contagem de instalados
$installedCount = 0

# Loop de instalacao e verificacao
foreach ($app in $apps) {
    if (Is-AppInstalled -AppName $app.Name) {
        Write-Log "$($app.Name) ja esta instalado."
        $installedCount++
    } else {
        Write-Log "Instalando $($app.Name)..."
        winget install --id=$($app.Id) --silent --accept-package-agreements --accept-source-agreements
        if ($LASTEXITCODE -eq 0) {
            Write-Log "$($app.Name) instalado com sucesso!"
            $installedCount++
        } else {
            Write-Log "Falha ao instalar $($app.Name)."
        }
    }
}

# Finalizacao
Write-Log "=== Processo finalizado ==="
Write-Log "Total de programas instalados: $installedCount de $($apps.Count)"
Write-Log "Log completo em: $LogFile"

# Mensagem resumida e encerramento
Write-Host "`n$installedCount de $($apps.Count) programas estao instalados."
Write-Host "Pressione ENTER para encerrar..."
Read-Host
