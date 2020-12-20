# setup winget
Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/Mitu217/dotfiles-windows/main/winget.ps1 -OutFile setup_winget.ps1
./setup_winget.ps1
Remove-Item setup_winget.ps1

# install winget's package

# setup chocolatey
Start-Process powershell.exe -Verb Runas -ArgumentList "-Command Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"

# install chocolatey's package
Start-Process powershell.exe -Verb Runas -ArgumentList "-Command iex(new-object net.webclient).downloadstring('https://raw.githubusercontent.com/Mitu217/dotfiles-windows/main/chocolatey_packages.ps1'); pause"

# setup wsl2
Start-Process powershell.exe -Verb Runas -ArgumentList "-Command iex(new-object net.webclient).downloadstring('https://raw.githubusercontent.com/Mitu217/dotfiles-windows/main/wsl2.ps1'); pause"

# when you double-click a zip file, it will be immediately unzipped by 7zip
#Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/Mitu217/dotfiles-windows/main/7-zip-default-extract.reg -OutFile 7-zip-default-extract.reg
#reg import ./7-zip-default-extract.reg
#Remove-Item ./7-zip-default-extract.reg
