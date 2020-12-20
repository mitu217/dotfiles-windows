# DO NOT RUN ON ISE
# Set-ExecutionPolicy -Scope Process Unrestricted

$DOTFILES = "$env:USERPROFILE\.dotfiles"

echo $DOTFILES

if (Test-Path ("$DOTFILES")) {
  Set-Location $DOTFILES
  git pull
}
else {
  git config --global core.autoCRLF false
  git clone https://github.com/Mitu217/dotfiles-windows $DOTFILES
}

# packages
Start-Process powershell.exe -ArgumentList "-Command $DOTFILES/package/winget/bundle.ps1" -Wait
Start-Process powershell.exe -ArgumentList "-Command $DOTFILES/package/scoop/bundle.ps1" -Wait -Verb Runas
Start-Process powershell.exe -ArgumentList "-Command $DOTFILES/package/chocolatey/bundle.ps1" -Wait -Verb Runas

# setup winget && install packages
# iex(new-object net.webclient).downloadstring('https://raw.githubusercontent.com/Mitu217/dotfiles-windows/main/winget/setup.ps1')
# iex(new-object net.webclient).downloadstring('https://raw.githubusercontent.com/Mitu217/dotfiles-windows/main/winget/package.ps1')

# setup chocolatey && install packages
# Start-Process powershell.exe -Verb Runas -ArgumentList "-Command Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" -Wait
# Start-Process powershell.exe -Verb Runas -ArgumentList "-Command iex(new-object net.webclient).downloadstring('https://raw.githubusercontent.com/Mitu217/dotfiles-windows/main/chocolatey_packages.ps1'); pause" -Wait

# setup wsl2
# Start-Process powershell.exe -Verb Runas -ArgumentList "-Command iex(new-object net.webclient).downloadstring('https://raw.githubusercontent.com/Mitu217/dotfiles-windows/main/wsl2.ps1'); pause" -Wait

# when you double-click a zip file, it will be immediately unzipped by 7zip
#Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/Mitu217/dotfiles-windows/main/7-zip-default-extract.reg -OutFile 7-zip-default-extract.reg
#reg import ./7-zip-default-extract.reg
#Remove-Item ./7-zip-default-extract.reg
