# DO NOT RUN ON ISE
# Set-ExecutionPolicy -Scope Process Unrestricted

$USERPROFILE = "$env:USERPROFILE"
Push-Location $USERPROFILE

# ---------------------------------------------
# Install VCRUNTIME140_1.dll for winget command
# ---------------------------------------------
if (Test-Path "C:\Windows\System32\vcruntime140_1.dll") {
    "vcruntime140_1.dll already exist"
} else {
    Invoke-WebRequest -Uri "https://aka.ms/vs/16/release/vc_redist.x64.exe" -OutFile vc_redist.x64.exe
    Start-Process powershell.exe -ArgumentList "-Command .\vc_redist.x64.exe /q" -Wait
    Remove-Item .\vc_redist.x64.exe
}

# --------------
# Install winget
# --------------
try {
    Get-Command -Name winget -ErrorAction Stop
}
catch [System.Management.Automation.CommandNotFoundException] {
    Invoke-WebRequest -UseBasicParsing -Uri https://github.com/microsoft/winget-cli/releases/download/v0.2.3162-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle -OutFile winget-cli.appbundle
    Add-AppPackage winget-cli.appbundle
    Remove-Item winget-cli.appbundle

    # copy settings
    # 1. enable experimental mode
    #   a. list command 
    #     list command is not perfect (https://github.com/microsoft/winget-cli/issues/119)
    Copy-Item settings.json $env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json
}


# ----------------
# Install packages
# ----------------
winget source update
$WINGET_PACKAGES = @(
    # Environment
    "1password"
    "CPU-Z"
    "GPU-Z"
    "Google Chrome"
    "AutoHotkey"
    "7Zip"

    # Communicate
    "Discord"
    "Notion"
    "Slack"

    # Development
    "Windows Terminal"
    "Git"
    "Fork"
    "Ubuntu"

    # Editor
    "Visual Studio Code (User Installer - x64)"
    "Sublime Text"
    
    # JetBrians
    "GoLand"
    "Rider"

    # Unity
    "Unity Hub"
)
foreach($PACKAGE in $WINGET_PACKAGES){
    # Returns a Boolean value by Quiet option
    if (winget list | Select-String -Pattern $PACKAGE -Quiet)
    {
        "$PACKAGE already installed"
    }
    elseif (($PACKAGE -eq "7Zip") -And (winget list | Select-String -Pattern "7-Zip" -Quiet)) {
        "$PACKAGE already installed"
    } 
    elseif (($PACKAGE -eq "Visual Studio Code (User Installer - x64)") -And (winget list | Select-String -Pattern "Visual Studio Code" -Quiet)) {
        "$PACKAGE already installed"
    }
    else
    {
        winget install $PACKAGE
    }
}

# ----------------
# Windows Settings
# ----------------

# Hide known file extensions
Write-Output "Hiding known file extensions..."
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "HideFileExt" -Type DWord -Value 1

# Hide hidden files
Write-Output "Hiding hidden files..."
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Hidden" -Type DWord -Value 2

# Disable Cortana
Write-Host "Disabling Cortana..."
If (!(Test-Path "HKCU:\Software\Microsoft\Personalization\Settings")) {
    New-Item -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Force | Out-Null
}
Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -name "ShowCortanaButton" -Value 0

# Disable Bing Search in Start Menu
Write-Host "Disabling Bing Search in Start Menu..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0

# Disable Cortana
Write-Host "Disabling Cortana..."
If (!(Test-Path "HKCU:\Software\Microsoft\Personalization\Settings")) {
    New-Item -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Force | Out-Null
}
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
If (!(Test-Path "HKCU:\Software\Microsoft\InputPersonalization")) {
    New-Item -Path "HKCU:\Software\Microsoft\InputPersonalization" -Force | Out-Null
}
Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
If (!(Test-Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore")) {
    New-Item -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-Null
}
Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0

# Hide Search button / box
Write-Host "Hiding Search Box / Button..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Type DWord -Value 0

# Hide Task View button
Write-Host "Hiding Task View button..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Type DWord -Value 0

# Show all tray icons
Write-Output "Showing all tray icons..."
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Type DWord -Value 0

# Hide Recycle Bin shortcut on desktop
Write-Output "Hide Recycle Bin shortcut on desktop..."
If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Force | Out-Null
}
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\ClassicStartMenu" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Type DWord -Value 1
If (!(Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel")) {
    New-Item -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Force | Out-Null
}
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Type DWord -Value 1

# Disable OneDrive
Write-Output "Disabling OneDrive..."
If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive")) {
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" | Out-Null
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Type DWord -Value 1

# Show small icons in taskbar
Write-Output "Showing small icons in taskbar..."
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarSmallIcons" -Type DWord -Value 1

# Hide IME Status
Write-Output "Hide IME Status..."
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\IME\15.0\IMEJP\MSIME" -Name "ShowImeModeNotification" -Type DWord -Value 0


# ----
# WSL2
# ----

dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

Invoke-WebRequest -UseBasicParsing -Uri "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -OutFile "$DOTFILES\wsl_update_x64.msi"
msiexec.exe /i "$DOTFILES\wsl_update_x64.msi" /quiet
Remove-Item "$DOTFILES\wsl_update_x64.msi"

Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All

wsl --set-default-version 2
Copy-Item ../.wslconfig "$env:USERPROFILE\.wslconfig"
wsl --shutdown
