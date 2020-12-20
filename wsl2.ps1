# enable VM
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# enable WSL
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# update wsl kernel components (https://docs.microsoft.com/ja-jp/windows/wsl/install-win10#step-4---download-the-linux-kernel-update-package)
Invoke-WebRequest -UseBasicParsing -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -OutFile C:\Users\mtksk\Downloads\wsl_update_x64.msi
msiexec.exe /i "C:\Users\mtksk\Downloads\wsl_update_x64.msi" /quiet
Remove-Item C:\Users\mtksk\Downloads\wsl_update_x64.msi

# set default version
wsl --set-default-version 2

