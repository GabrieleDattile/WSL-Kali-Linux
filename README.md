# Script per Installare WSL, Kali Linux e Win-KeX

Questo script automatizza l'installazione di WSL, Kali Linux e dell'ambiente grafico Win-KeX su un sistema Windows.

## Requisiti

- **Sistema Operativo**: Windows 10 o Windows 11 (build 19041 o successiva).
- **Permessi**: PowerShell con permessi di amministratore.

---

## Istruzioni

### 1. Esegui lo Script
1. Salva lo script in un file con estensione `.ps1` (esempio: `install-kali-wsl-kex.ps1`).
2. Apri **PowerShell** come amministratore.
3. Esegui il comando seguente per avviare lo script:
   ```powershell
   .\install-kali-wsl-kex.ps1

# Modalità di Utilizzo di Win-KeX

Win-KeX è un ambiente grafico per Kali Linux su WSL che offre diverse modalità di visualizzazione. Questo documento spiega come utilizzare e configurare Win-KeX.

---

## Modalità Disponibili

### 1. Modalità a Schermo Intero
Per avviare Win-KeX a schermo intero, esegui il seguente comando:
```bash
kex --win -s
