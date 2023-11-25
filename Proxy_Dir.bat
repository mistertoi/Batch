@echo off
@REM #
@REM # BM proxy-Manager benutzen und dann die
@REM # Proxy-Dateien auf den eigenen Rechner übertragen
@REM #

@REM # TESTDATEIPFAD: 2023_1106_WDR_LokD_Test

@REM # verzögerte Variablenexpansion aktivieren
setlocal enabledelayedexpansion

set /p unterverzeichnis="Bitte gib den Namen des Unterverzeichnisses an, das kopiert werden soll: "
set quelle="X:\%unterverzeichnis%"
set ziel1="H:\Videos\%unterverzeichnis%"
set ziel2="H:\Videos"

@REM # Wenn das Verzeichnis nicht existiert: Fehlermeldung ausgeben
if not exist %quelle% (
    echo Das angegebene Unterverzeichnis existiert nicht im Quellverzeichnis.
    pause
    exit /b
)

@REM # Verzeichnisbaum OHNE Dateien kopieren
robocopy "%quelle%" "%ziel1%" /e /NOCOPY /DCOPY:T

@REM # Prüfung, ob Proxy-Dateien/-Verzeichnisse vorhanden sind
@REM # und NUR DIESE dann auf das Ziellaufwerk kopieren
@REM # anschliessend Benutzereingabe abwarten
for /f "delims=" %%a in ('dir /s /b /ad "%quelle%" ^| findstr /iec:"\\Proxy"') do robocopy "%%a" "%ziel2%%%~pna" /e
pause
