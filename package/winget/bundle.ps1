$DOTFILES = "$env:USERPROFILE\.dotfiles"

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
    Copy-Item $DOTFILES/package/winget/settings.json $env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json
}

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
    "Git"
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
