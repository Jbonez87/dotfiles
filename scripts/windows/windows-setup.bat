@echo off

echo Installing Chocolatey...
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

echo Installing Git...
choco install git -y

echo Installing Git Bash...
choco install git-extensions -y

echo Installing NVM...
choco install nvm -y

echo Installing Node.js...
call nvm install 16.14.2

echo Installing Rust...
choco install rust -y

echo Installation complete.
