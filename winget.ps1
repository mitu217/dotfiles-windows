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

# install packages
$WINGET_PACKAGES = @()
winget install "1password"
winget install "CPU-Z"
winget install "GPU-Z"
winget install "Discord"
winget install "Fork"
winget install "AutoHotkey"
winget install "7Zip"
winget install "Windows Terminal"
winget install "Unity Hub"
winget install "Slack"
winget install "Visual Studio Code"
winget install "Sublime Text"
winget install "Google Chrome"
winget install "Notion"
winget install "Git"
winget install "Ubuntu"
