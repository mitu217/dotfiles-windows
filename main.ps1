# setup winget
Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/Mitu217/dotfiles-windows/main/winget.ps1 -OutFile winget.ps1
./winget.ps1
Remove-Item winget.ps1

# setup wsl2
Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/Mitu217/dotfiles-windows/main/wsl2.ps1 -OutFile wsl2.ps1
./wsl2.ps1
Remove-Item wsl2.ps1


# when you double-click a zip file, it will be immediately unzipped by 7zip
Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/Mitu217/dotfiles-windows/main/7-zip-default-extract.reg -OutFile 7-zip-default-extract.reg
reg import ./7-zip-default-extract.reg
Remove-Item ./7-zip-default-extract.reg
