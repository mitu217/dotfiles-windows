# DO NOT RUN ON ISE
# Set-ExecutionPolicy -Scope Process Unrestricted

$DOTFILES = "$env:USERPROFILE\.dotfiles"

if (Test-Path ("$DOTFILES")) {
  Push-Location $DOTFILES
  git pull
  Pop-Location
}
else {
  git config --global core.autoCRLF false
  git clone https://github.com/Mitu217/dotfiles-windows $DOTFILES
}

# install packages
Start-Process powershell.exe -ArgumentList "-Command $DOTFILES/package/winget/bundle.ps1" -Wait
Start-Process powershell.exe -ArgumentList "-Command $DOTFILES/package/scoop/bundle.ps1" -Wait -Verb Runas
Start-Process powershell.exe -ArgumentList "-Command $DOTFILES/package/chocolatey/bundle.ps1" -Wait -Verb Runas

# setup wsl2
Start-Process powershell.exe -ArgumentList "-Command $DOTFILES/wsl2/wsl2.ps1" -Wait -Verb Runas

# setup config
Start-Process powershell.exe -ArgumentList "-Command $DOTFILES/config/config.ps1" -Wait -Verb Runas
