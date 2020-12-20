# install winget
# not needed once winget is released
if (Get-Command winget -errorAction SilentlyContinue)
{
    "already installed winget"
}
else
{
    Invoke-WebRequest -UseBasicParsing -Uri https://github.com/microsoft/winget-cli/releases/download/v0.2.3162-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle -OutFile winget-cli.appbundle
    Add-AppPackage winget-cli.appbundle
    Remove-Item winget-cli.appbundle
}

# settings
# 1. enable experimental mode
#   a. list command
#     list command is not perfect (https://github.com/microsoft/winget-cli/issues/119)
Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/Mitu217/dotfiles-windows/main/settings.json -OutFile $env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json

# install packages
winget source update
$WINGET_PACKAGES = @(
    "1password"
    "CPU-Z"
    "GPU-Z"
    "Discord"
    "Fork"
    "AutoHotkey"
    "7Zip"
    "Windows Terminal"
    "Unity Hub"
    "Slack"
    "Ubuntu"
    "Visual Studio Code"
    "Sublime Text"
    "Google Chrome"
    "Notion"
)
foreach($PACKAGE in $WINGET_PACKAGES){
    # Returns a Boolean value by Quiet option
    if (winget list | Select-String -Pattern $PACKAGE -Quiet)
    {
        "$PACKAGE already installed"
    }
    else
    {
        winget install $PACKAGE
    }
}
