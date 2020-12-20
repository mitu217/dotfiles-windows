# windows-dotfiles
dotfiles for windows

* install packages by winget
* when you double-click a zip file, it will be immediately unzipped by 7zip

## Install
running on PowerShell

```ps
Set-ExecutionPolicy -Scope Process Unrestricted && chcp 65001
iex(new-object net.webclient).downloadstring('https://raw.githubusercontent.com/Mitu217/dotfiles-windows/main/main.ps1')
```
