# ============================================
# Wake-On-LAN + Desligamento + Verificacao OMV
# ============================================

# Author: Wellington Albuquerque Falcão
# Version: 0.2
# Date: 10/22/2025
# Contact: wellingtonfalcao@gmail.com

# ---- CONFIGURACOES ----
$macAddress = "74-D0-2B-CC-77-7F"
$ipAddress  = "192.168.31.40"
$hostname   = "FALCON-NAS"
$username   = "root"

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

    Write-Host "Pacote WOL enviado para $mac ($subnetBroadcast:9)"
}

# ---- DESLIGAMENTO VIA SSH COM CONFIRMACAO ----
function Remote-ShutdownSSH {
    param([string]$remoteIP, [string]$user)

    Write-Host "Tentando desligar $remoteIP via SSH..."
    try {
        $sshCommand = "$user@$remoteIP shutdown -h now"
        Start-Process ssh -ArgumentList $sshCommand -Wait

        # Aguarda o host desligar
        $timeout = 60  # tempo maximo de espera em segundos
        $elapsed = 0
        while ($elapsed -lt $timeout) {
            if (-not (Test-Online -ip $remoteIP)) {
                Write-Host "$remoteIP foi desligado com sucesso!"
                return
            }
            Start-Sleep -Seconds 2
            $elapsed += 2
        }
        Write-Host "$remoteIP nao desligou dentro do timeout."
    } catch {
        Write-Host "Falha ao desligar via SSH: $($_.Exception.Message)"
    }
}

# ---- CHECAGEM DO SERVICO OMV ----
function Check-OMVService {
    param([string]$remoteIP, [string]$user)

    try {
        $sshArgs = "$user@$remoteIP systemctl is-active openmediavault-engined"
        $status = ssh $sshArgs 2>$null | Out-String
        $status = $status.Trim()  # remove espaços e quebras de linha
        if ($status -eq "active") { return $true } else { return $false }
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

# ---- LOOP DO MENU ----
do {
    Clear-Host
    Write-Host "============================="
    Write-Host "   Wake-on-LAN / Power Menu"
    Write-Host "============================="

    if (Test-Online -ip $ipAddress) {
        Write-Host "Status atual: ONLINE ($ipAddress)"
        Start-Sleep -Seconds 15  # espera para o OMV carregar
        if (Check-OMVService -remoteIP $ipAddress -user $username) {
            Write-Host "Servico OMV: ATIVO"
        } else {
            Write-Host "Servico OMV: INATIVO"
        }
    } else {
        Write-Host "Status atual do NAS: OFFLINE ($ipAddress)"
        Write-Host "Servico OMV: Indisponivel"
    }

    Write-Host ""
    Write-Host "1. Ligar NAS ($hostname)"
    Write-Host "2. Desligar NAS ($hostname)"
    Write-Host "3. Sair da Aplicacao"
    Write-Host "============================="
    $choice = Read-Host "Escolha uma opcao (1-3)"

    switch ($choice) {
        "1" { 
            Send-WakeOnLan -mac $macAddress
            Write-Host "Ligando $hostname..."
            if (Wait-ForOnline -ip $ipAddress -timeout 30) {
                Write-Host "$hostname esta ONLINE"
                Start-Sleep -Seconds 15  # espera para o OMV carregar
                if (Check-OMVService -remoteIP $ipAddress -user $username) {
                    Write-Host "Servico OMV: ATIVO"
                } else {
                    Write-Host "Servico OMV: INATIVO"
                }
            } else {
                Write-Host "$hostname nao respondeu ao ping dentro do timeout."
            }
        }
        "2" { 
            Remote-ShutdownSSH -remoteIP $ipAddress -user $username
            # Reinicia o menu automaticamente após desligar
        }
        "3" { Write-Host "Desligando..." }
        default { Write-Host "Opcao invalida." }
    }

} while ($choice -ne "3")
