# installeer.ps1 - installeert (of werkt bij) Card-Turn-Up voor deze gebruiker.
# Gebruik: open PowerShell en plak
#   irm https://raw.githubusercontent.com/HPDesignJetZ9/card-turn-up-releases/main/installeer.ps1 | iex
# Downloadt de nieuwste installer van GitHub en start de gewone installatiewizard.
# Geen beheerdersrechten nodig; installeert in %LOCALAPPDATA%\Programs\CardTurnUp.

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'      # anders is downloaden in PowerShell 5 erg traag
$url  = 'https://github.com/HPDesignJetZ9/card-turn-up-releases/releases/latest/download/CardTurnUp-Setup.exe'
$doel = Join-Path $env:TEMP 'CardTurnUp-Setup.exe'

try {
    Write-Host ''
    Write-Host 'Card-Turn-Up: nieuwste versie downloaden...' -ForegroundColor Cyan
    Invoke-WebRequest -Uri $url -OutFile $doel -UseBasicParsing
    if ((Get-Item $doel).Length -lt 100000) { throw 'De download is onvolledig.' }

    Write-Host 'Installatie starten (volg het venster dat verschijnt)...' -ForegroundColor Cyan
    $p = Start-Process -FilePath $doel -Wait -PassThru
    Remove-Item $doel -ErrorAction SilentlyContinue
    if ($p.ExitCode -ne 0) { throw "De installatie is afgebroken of mislukt (code $($p.ExitCode))." }

    Write-Host ''
    Write-Host 'Klaar! Card-Turn-Up staat nu in het Startmenu.' -ForegroundColor Green
    Write-Host 'Nieuwe versies installeer je voortaan met de knop "Update" in het programma.'
}
catch {
    Write-Host ''
    Write-Host "Het lukte niet: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host 'Maak een foto of schermafbeelding van dit venster en stuur die naar de beheerder van Card-Turn-Up.'
}
