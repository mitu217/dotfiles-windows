$DOTFILES = "$env:USERPROFILE\.dotfiles"

# show file ext
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d "0" /f

# when you double-click a zip file, it will be immediately unzipped by 7zip
reg import "$DOTFILES\config\7-zip-default-extract.reg"
