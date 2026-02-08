# Windows Optimization Scripts
Uma coleção de scripts PowerShell para otimizar o desempenho do Windows desabilitando recursos desnecessários e telemetria. Baseado no trabalho de **Enzo Thulio** do canal **1155doET** no YouTube.

---

## 📋 Table of Contents
- [Overview](#-overview)
- [Features](#-features)
- [Prerequisites](#️-prerequisites)
- [Installation](#-installation)
- [Usage](#-usage)
- [Script Details](#-script-details)
- [Restoration](#-restoration)
- [Credits](#-credits)
- [Disclaimer](#️-disclaimer)
- [Support](#-support)

---

## 🚀 Overview
Esses scripts PowerShell foram criados para melhorar o desempenho do Windows em máquinas de baixa performance, desabilitando diversos serviços, telemetria, processos em segundo plano e funcionalidades que consomem recursos.  
As otimizações seguem configurações manuais demonstradas por **Enzo Thulio (1155doET)**.

---

## ✨ Features

### **Disabled/Configured Services**

#### **Telemetry & Diagnostics**
- Allow diagnostic data → **Disabled**
- Application Telemetry → **Disabled**
- Application Compatibility Telemetry → **Disabled**
- Program Compatibility Assistant → **Disabled**
- Inventory Collector → **Disabled**
- SwitchBack Compatibility → **Disabled**
- Steps Recorder → **Disabled**

#### **Cloud Services**
- Cloud optimized content → **Disabled**
- Consumer cloud account state content → **Disabled**
- Windows tips → **Disabled**
- Automatic speech data updates → **Disabled**

#### **Privacy & Location**
- Account-based insights in File Explorer → **Disabled**
- Windows location provider → **Disabled**
- Location services → **Disabled**
- Sensors → **Disabled**

#### **Search & Cortana**
- Cortana → **Disabled**
- Cloud search → **Disabled**
- Search highlights → **Disabled**
- Search location access → **Disabled**
- Automatic language detection → **Disabled**

#### **Updates & Background Apps**
- Automatic update downloads → **Notify before download**
- Background apps → **Forced denial**
- Activity feed → **Disabled**

---

## ⚙️ Prerequisites
- Windows 10 ou Windows 11  
- PowerShell com execução habilitada  
- Privilégios de administrador

---

## 📥 Installation

### **1. Baixar os scripts**
```powershell
# Download do script de otimização
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/your-repo/windows-optimization/main/debloat-windows.ps1" -OutFile "debloat-windows.ps1"

# Download do script de restauração
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/your-repo/windows-optimization/main/restore-windows.ps1" -OutFile "restore-windows.ps1"
