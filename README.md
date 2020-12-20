# windows-dotfiles
dotfiles for windows

* install packages by winget
* when you double-click a zip file, it will be immediately unzipped by 7zip

## Requirement

### WSL2
* Must be version 2004 (May 2020 Update), build 19041 or higher, or version 1903 (May 2019 Update), build 18362 or higher
* Please make sure that virtualization is enabled inside of your computer's BIOS 
  * `SVM Mode` for AMD Ryzen
  

## Install
running on PowerShell

```ps
Set-ExecutionPolicy -Scope Process Unrestricted
iex(new-object net.webclient).downloadstring('https://raw.githubusercontent.com/Mitu217/dotfiles-windows/main/main.ps1')
```
