# enable VM
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# enable WSL
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# update wsl kernel components (https://aka.ms/wsl2kernel)
Invoke-WebRequest -UseBasicParsing -Uri https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi -OutFile C:\Users\mtksk\Downloads\wsl_update_x64.msi
msiexec.exe /i "C:\Users\mtksk\Downloads\wsl_update_x64.msi" /quiet
Remove-Item C:\Users\mtksk\Downloads\wsl_update_x64.msi

# set default version
wsl --set-default-version 2

# enable hyper-v
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All
