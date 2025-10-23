# ============================================
# Wake-On-LAN + Desligamento + Verificacao OMV + Agendamento
# ============================================

# Author: Wellington Albuquerque Falcão
# Version: 1.0
# Date: 10/22/2025

# ---- CONFIGURACOES ----
$macAddress = "74-D0-2B-CC-77-7F"
$ipAddress  = "192.168.31.40"
$hostname   = "FALCON-NAS"
$username   = "root"
$shutdownScheduleFile = "$env:TEMP\wol_shutdown_schedule.txt"

# ---- VERIFICAR DEPENDENCIAS ----
if (-not (Get-Module -ListAvailable -Name Posh-SSH)) {
    Write-Host "Modulo Posh-SSH nao encontrado. Instalando..." -ForegroundColor Yellow
    Install-Module -Name Posh-SSH -Scope CurrentUser -Force
}
Import-Module Posh-SSH

# ---- TESTE DE CONEXAO ----
function Test-Online {
    param([string]$ip)
    return (Test-Connection -ComputerName $ip -Count 1 -Quiet)
}

# ---- WAKE-ON-LAN ----
function Send-WakeOnLan {
    param ([string]$mac, [string]$subnetBroadcast="192.168.31.255")
    $macClean = $mac -replace '[-:]', ''
    $macBytes = @()
    for ($i = 0; $i -lt 12; $i += 2) { 
        $macBytes += [byte]::Parse($macClean.Substring($i,2),'HexNumber') 
    }
    $packet = [byte[]](@(0xFF)*6 + ($macBytes*16))
    $udp = New-Object System.Net.Sockets.UdpClient
    $udp.EnableBroadcast = $true
    $udp.Connect([System.Net.IPAddress]::Parse($subnetBroadcast),9)
    [void]$udp.Send($packet,$packet.Length)
    $udp.Close()
    Write-Host "Pacote WOL enviado para $mac ($subnetBroadcast:9)" -ForegroundColor Green
}

# ---- DESLIGAMENTO VIA SSH COM CONFIRMACAO ----
function Remote-ShutdownSSH {
    param([string]$remoteIP, [string]$user, [string]$password)
    Write-Host "Tentando desligar $remoteIP via SSH..." -ForegroundColor Cyan
    try {
        $securePass = ConvertTo-SecureString $password -AsPlainText -Force
        $cred = New-Object System.Management.Automation.PSCredential ($user, $securePass)
        $session = New-SSHSession -ComputerName $remoteIP -Credential $cred -AcceptKey
        Invoke-SSHCommand -SessionId $session.SessionId -Command "shutdown -h now"
        Remove-SSHSession -SessionId $session.SessionId

        # Aguarda o host desligar
        $timeout = 60
        $elapsed = 0
        while ($elapsed -lt $timeout) {
            if (-not (Test-Online -ip $remoteIP)) {
                Write-Host "$remoteIP foi desligado com sucesso!" -ForegroundColor Green
                return
            }
            Start-Sleep -Seconds 2
            $elapsed += 2
        }
        Write-Host "$remoteIP nao desligou dentro do timeout." -ForegroundColor Yellow
    } catch {
        Write-Host "Falha ao desligar via SSH: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# ---- CHECAGEM DO SERVICO OMV ----
function Check-OMVService {
    param([string]$remoteIP, [string]$user, [string]$password)
    try {
        $securePass = ConvertTo-SecureString $password -AsPlainText -Force
        $cred = New-Object System.Management.Automation.PSCredential ($user, $securePass)
        $session = New-SSHSession -ComputerName $remoteIP -Credential $cred -AcceptKey
        $result = Invoke-SSHCommand -SessionId $session.SessionId -Command "systemctl is-active openmediavault-engined"
        Remove-SSHSession -SessionId $session.SessionId
        return $result.Output.Trim() -eq "active"
    } catch {
        return $false
    }
}

# ---- ESPERA O HOST FICAR ONLINE ----
function Wait-ForOnline {
    param([string]$ip,[int]$timeout=30)
    $elapsed=0
    while ($elapsed -lt $timeout) {
        if (Test-Online -ip $ip) { return $true }
        Start-Sleep -Seconds 2
        $elapsed += 2
    }
    return $false
}

# ---- AGENDAMENTO DE DESLIGAMENTO ----
function Schedule-Shutdown {
    param([string]$time)
    Set-Content -Path $shutdownScheduleFile -Value $time
    Write-Host "!!! Agendamento de desligamento definido para $time !!!" -ForegroundColor Magenta
}

function Cancel-Shutdown {
    if (Test-Path $shutdownScheduleFile) {
        Remove-Item $shutdownScheduleFile
        Write-Host "Agendamento de desligamento cancelado com sucesso!" -ForegroundColor DarkMagenta
    }
}

function Get-ScheduledShutdown {
    if (Test-Path $shutdownScheduleFile) {
        return Get-Content $shutdownScheduleFile
    }
    return $null
}

# ---- ACESSO SSH INTERATIVO ----
function SSH-Access {
    param([string]$remoteIP, [string]$user, [string]$password)
    try {
        $securePass = ConvertTo-SecureString $password -AsPlainText -Force
        $cred = New-Object System.Management.Automation.PSCredential ($user, $securePass)
        Write-Host "Conectando via SSH a $remoteIP..." -ForegroundColor Cyan
        Start-Process ssh -ArgumentList "$user@$remoteIP" -NoNewWindow -Wait
    } catch {
        Write-Host "Falha ao abrir SSH: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# ---- LOOP DO MENU ----
do {
    Clear-Host
    Write-Host "=============================" -ForegroundColor Cyan
    Write-Host "   Wake-on-LAN / Power Menu" -ForegroundColor Cyan
    Write-Host "=============================" -ForegroundColor Cyan

    $scheduledShutdown = Get-ScheduledShutdown
    if ($scheduledShutdown) {
        Write-Host ">>> Horario de desligamento agendado: $scheduledShutdown <<<" -ForegroundColor Magenta
    }

    if (Test-Online -ip $ipAddress) {
        Write-Host "Status atual: ONLINE ($ipAddress)" -ForegroundColor Green

        $password = Read-Host -AsSecureString "Digite a senha de $username@$ipAddress para verificar status do OMV"
        $plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(
            [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
        )

        if (Check-OMVService -remoteIP $ipAddress -user $username -password $plainPassword) {
            Write-Host "Servico OMV: ATIVO" -ForegroundColor Cyan
        } else {
            Write-Host "Servico OMV: INATIVO" -ForegroundColor Yellow
        }

    } else {
        Write-Host "Status atual do NAS: OFFLINE ($ipAddress)" -ForegroundColor Red
        Write-Host "Servico OMV: Indisponivel" -ForegroundColor DarkGray
    }

    Write-Host ""
    Write-Host "1. Ligar NAS ($hostname)" -ForegroundColor White
    Write-Host "2. Desligar NAS ($hostname)" -ForegroundColor White
    Write-Host "3. Acessar terminal SSH" -ForegroundColor White
    Write-Host "4. Agendar desligamento" -ForegroundColor White
    if ($scheduledShutdown) { Write-Host "5. Cancelar agendamento" -ForegroundColor White }
    Write-Host "6. Sair da aplicacao" -ForegroundColor White
    Write-Host "=============================" -ForegroundColor Cyan
    $choice = Read-Host "Escolha uma opcao"

    switch ($choice) {
        "1" { 
            Send-WakeOnLan -mac $macAddress
            Write-Host "Ligando $hostname..."
            if (Wait-ForOnline -ip $ipAddress -timeout 30) {
                Write-Host "$hostname esta ONLINE" -ForegroundColor Green
                if (Check-OMVService -remoteIP $ipAddress -user $username -password $plainPassword) {
                    Write-Host "Servico OMV: ATIVO" -ForegroundColor Cyan
                } else {
                    Write-Host "Servico OMV: INATIVO" -ForegroundColor Yellow
                }
            } else {
                Write-Host "$hostname nao respondeu ao ping dentro do timeout." -ForegroundColor Red
            }
        }
        "2" { 
            Remote-ShutdownSSH -remoteIP $ipAddress -user $username -password $plainPassword
        }
        "3" {
            SSH-Access -remoteIP $ipAddress -user $username -password $plainPassword
        }
        "4" {
            $time = Read-Host "Digite o horario para desligamento (HH:mm)"
            Schedule-Shutdown -time $time
        }
        "5" {
            if ($scheduledShutdown) { Cancel-Shutdown }
        }
        "6" { Write-Host "Desligando aplicacao..." -ForegroundColor Cyan }
        default { Write-Host "Opcao invalida." -ForegroundColor Red }
    }

} while ($choice -ne "6")
