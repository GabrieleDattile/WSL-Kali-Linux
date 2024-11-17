# Installa WSL e configura WSL 2 come versione predefinita
Write-Host "Installazione di WSL e configurazione della versione 2..." -ForegroundColor Green
wsl --install

# Installa Kali Linux
Write-Host "Installazione di Kali Linux..." -ForegroundColor Green
Invoke-Expression "ms-windows-store://pdp/?productid=9PKR34TNCV07"
Write-Host "Apri Microsoft Store, installa Kali Linux e premi Invio per continuare una volta completato."
Pause

# Configura Kali Linux e installa Win-KeX
Write-Host "Configurazione di Kali Linux e installazione di Win-KeX..." -ForegroundColor Green
wsl -d kali-linux -- bash -c "
sudo apt update && sudo apt install -y kali-win-kex
"

Write-Host "Installazione completata! Apri Kali Linux e usa il comando 'kex' per avviare l'ambiente grafico."
