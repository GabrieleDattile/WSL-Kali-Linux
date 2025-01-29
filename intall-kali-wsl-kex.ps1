# Richiede privilegi amministrativi
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Richiesta elevazione dei privilegi..." -ForegroundColor Yellow
    Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Funzione per riavviare il sistema
function Request-Reboot {
    $choice = Read-Host "`nE' necessario riavviare il sistema. Riavviare ora? (s/n)"
    if ($choice -eq 's') {
        Write-Host "Riavvio in corso..."
        shutdown /r /t 0
    } else {
        Write-Host "Ricordati di riavviare manualmente prima di utilizzare WSL!" -ForegroundColor Yellow
        exit
    }
}

# 1. Abilitazione WSL e configurazione versione 2
try {
    if ((wsl -l -q) -eq $null) {
        Write-Host "Configurazione WSL 2..." -ForegroundColor Green
        dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
        dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
        wsl --set-default-version 2
        Request-Reboot
    }
} catch {
    Write-Host "Errore nella configurazione WSL: $_" -ForegroundColor Red
    exit
}

# 2. Installazione Kali Linux
if (-NOT (wsl -l | Select-String "kali-linux")) {
    try {
        Write-Host "Installazione Kali Linux..." -ForegroundColor Green
        winget install KaliLinux.KaliLinux --accept-package-agreements --accept-source-agreements
        
        # Attesa completamento installazione
        do {
            Start-Sleep -Seconds 5
        } until (Get-Process -Name "ubuntu" -ErrorAction SilentlyContinue)
        
        # Configurazione iniziale
        wsl -d kali-linux -e sudo apt update
        wsl -d kali-linux -e sudo apt upgrade -y
    } catch {
        Write-Host "Errore nell'installazione di Kali Linux: $_" -ForegroundColor Red
        exit
    }
}

# 3. Configurazione Win-KeX
try {
    Write-Host "Installazione Win-KeX..." -ForegroundColor Green
    wsl -d kali-linux -e sudo apt install -y kali-win-kex
    
    # Configurazione automatica
    wsl -d kali-linux -e bash -c "echo -e 'kex --win -s\n' >> ~/.bashrc"
    
    # Avvio automatico al primo utilizzo
    Write-Host "`nConfigurazione completata! Usa questi comandi:" -ForegroundColor Green
    Write-Host "1. Per avviare Kali Linux: wsl -d kali-linux"
    Write-Host "2. Per lanciare l'interfaccia grafica: kex --win -s"
    Write-Host "3. Per la modalità seamless: kex --sl -s"
} catch {
    Write-Host "Errore nell'installazione di Win-KeX: $_" -ForegroundColor Red
    exit
}

# Verifica finale
try {
    $check = wsl -d kali-linux -e bash -c "which kex"
    if ($check -match "kex") {
        Write-Host "`nInstallazione completata con successo!" -ForegroundColor Green
    }
} catch {
    Write-Host "Si e' verificato un problema nel setup finale" -ForegroundColor Yellow
}