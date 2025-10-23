# ============================================
# Wake-On-LAN + Desligamento + Verificacao OMV + Terminal SSH + Agendamento
# ============================================

# Author: Wellington Albuquerque Falcão
# Version: 1.0
# Date: 10/22/2025

# ---- CONFIGURACOES ----
$macAddress = "74-D0-2B-CC-77-7F"
$ipAddress  = "192.168.31.40"
$hostname   = "FALCON-NAS"
$username   = "root"

# ---- VARIAVEIS DE AGENDAMENTO ----
$shutdownSchedule = $null

# ---- VERIFICAR DEPENDENCIAS ----
if (-not (Get-Module -ListAvailable -Name Posh-SSH)) {
    Write-Host "Modulo Posh-SSH nao encontrado. Instalando..."
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
    Write-Host "Pacote WOL enviado para $mac ($subnetBroadcast:9)"
}

# ---- DESLIGAMENTO VIA SSH COM CONFIRMACAO ----
function Remote-ShutdownSSH {
    param([string]$remoteIP, [string]$user, [string]$password)
    Write-Host "Tentando desligar $remoteIP via SSH..."
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

# ---- AGENDAR DESLIGAMENTO VIA SSH ----
function Schedule-ShutdownSSH {
    param([string]$remoteIP, [string]$user, [string]$password)
    $hora = Read-Host "Digite o horario de desligamento no formato HH:MM (24h)"
    try {
        $securePass = ConvertTo-SecureString $password -AsPlainText -Force
        $cred = New-Object System.Management.Automation.PSCredential ($user, $securePass)
        $session = New-SSHSession -ComputerName $remoteIP -Credential $cred -AcceptKey
        Invoke-SSHCommand -SessionId $session.SessionId -Command "shutdown -h $hora"
        Remove-SSHSession -SessionId $session.SessionId

        $script:shutdownSchedule = $hora
        Write-Host "Desligamento agendado com sucesso para $hora"
    } catch {
        Write-Host "Falha ao agendar desligamento: $($_.Exception.Message)"
    }
}

# ---- CANCELAR AGENDAMENTO DE DESLIGAMENTO ----
function Cancel-ShutdownSchedule {
    param([string]$remoteIP, [string]$user, [string]$password)
    if (-not $shutdownSchedule) {
        Write-Host "Nenhum desligamento agendado."
        return
    }
    try {
        $securePass = ConvertTo-SecureString $password -AsPlainText -Force
        $cred = New-Object System.Management.Automation.PSCredential ($user, $securePass)
        $session = New-SSHSession -ComputerName $remoteIP -Credential $cred -AcceptKey
        Invoke-SSHCommand -SessionId $session.SessionId -Command "shutdown -c"
        Remove-SSHSession -SessionId $session.SessionId

        $script:shutdownSchedule = $null
        Write-Host "Agendamento de desligamento cancelado com sucesso."
    } catch {
        Write-Host "Falha ao cancelar desligamento: $($_.Exception.Message)"
    }
}

# ---- ACESSO AO TERMINAL SSH ----
function SSH-Terminal {
    param([string]$remoteIP, [string]$user, [string]$password)
    Write-Host "Abrindo terminal SSH para $remoteIP..."
    try {
        $securePass = ConvertTo-SecureString $password -AsPlainText -Force
        $cred = New-Object System.Management.Automation.PSCredential ($user, $securePass)
        $session = New-SSHSession -ComputerName $remoteIP -Credential $cred -AcceptKey
        Invoke-SSHCommand -SessionId $session.SessionId -Command "bash" -Interactive
        Remove-SSHSession -SessionId $session.SessionId
    } catch {
        Write-Host "Falha ao abrir terminal SSH: $($_.Exception.Message)"
    }
}

# ---- LOOP DO MENU ----
do {
    Clear-Host
    Write-Host "============================="
    Write-Host "   Wake-on-LAN / Power Menu"
    Write-Host "============================="

    if (Test-Online -ip $ipAddress) {
        Write-Host "Status atual: ONLINE ($ipAddress)"
        $password = Read-Host -AsSecureString "Digite a senha de $username@$ipAddress para verificar status do OMV"
        $plainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(
            [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password)
        )

        if (Check-OMVService -remoteIP $ipAddress -user $username -password $plainPassword) {
            Write-Host "Servico OMV: ATIVO"
        } else {
            Write-Host "Servico OMV: INATIVO"
        }
    } else {
        Write-Host "Status atual do NAS: OFFLINE ($ipAddress)"
        Write-Host "Servico OMV: Indisponivel"
    }

    if ($shutdownSchedule) {
        Write-Host ""
        Write-Host "!!! Desligamento agendado para: $shutdownSchedule !!!"
    }

    Write-Host ""
    Write-Host "1. Ligar NAS ($hostname)"
    Write-Host "2. Desligar NAS ($hostname)"
    Write-Host "3. Sair da Aplicacao"
    Write-Host "4. Acessar terminal SSH ($hostname)"
    Write-Host "5. Agendar desligamento ($hostname)"

    if ($shutdownSchedule) {
        Write-Host "6. Cancelar agendamento de desligamento"
    }

    Write-Host "============================="
    $choice = Read-Host "Escolha uma opcao (1-6)"

    switch ($choice) {
        "1" { 
            Send-WakeOnLan -mac $macAddress
            Write-Host "Ligando $hostname..."
            if (Wait-ForOnline -ip $ipAddress -timeout 30) {
                Write-Host "$hostname esta ONLINE"
                if (Check-OMVService -remoteIP $ipAddress -user $username -password $plainPassword) {
                    Write-Host "Servico OMV: ATIVO"
                } else {
                    Write-Host "Servico OMV: INATIVO"
                }
            } else {
                Write-Host "$hostname nao respondeu ao ping dentro do timeout."
            }
        }
        "2" { Remote-ShutdownSSH -remoteIP $ipAddress -user $username -password $plainPassword }
        "3" { Write-Host "Desligando aplicacao..." }
        "4" { SSH-Terminal -remoteIP $ipAddress -user $username -password $plainPassword }
        "5" { 
            Schedule-ShutdownSSH -remoteIP $ipAddress -user $username -password $plainPassword
            Write-Host "!!! Agendamento realizado com sucesso !!!"
        }
        "6" {
            if ($shutdownSchedule) {
                Cancel-ShutdownSchedule -remoteIP $ipAddress -user $username -password $plainPassword
                Write-Host "!!! Agendamento cancelado com sucesso !!!"
            } else {
                Write-Host "Nenhum agendamento ativo para cancelar."
            }
        }
        default { Write-Host "Opcao invalida." }
    }

} while ($choice -ne "3")