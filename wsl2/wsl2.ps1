$DOTFILES = "$env:USERPROFILE\.dotfiles"

# enable VM
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# enable WSL
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# update wsl kernel components (https://aka.ms/wsl2kernel)
Invoke-WebRequest -UseBasicParsing -Uri "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -OutFile "$DOTFILES\wsl_update_x64.msi"
msiexec.exe /i "$DOTFILES\wsl_update_x64.msi" /quiet
Remove-Item "$DOTFILES\wsl_update_x64.msi"

# enable hyper-v
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

# set default version
wsl --set-default-version 2

# setup config
Copy-Item ../.wslconfig "$env:USERPROFILE\.wslconfig"
wsl --shutdown
