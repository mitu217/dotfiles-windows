# enable VM
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# enable WSL
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
wsl --set-default-version 2

