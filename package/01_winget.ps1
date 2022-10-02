$WINGET_VERSION = "v1.3.2091"

try {
    Get-Command -Name winget -ErrorAction Stop
}
catch [System.Management.Automation.CommandNotFoundException] {
    Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/microsoft/winget-cli/releases/download/$WINGET_VERSION/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -OutFile winget-cli.appbundle
    Add-AppPackage winget-cli.appbundle
    Remove-Item winget-cli.appbundle

    # copy settings
    # 1. enable experimental mode
    #   a. list command 
    #     list command is not perfect (https://github.com/microsoft/winget-cli/issues/119)
    Copy-Item $DOTFILES/package/winget/settings.json $env:LOCALAPPDATA\Packages\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe\LocalState\settings.json
}
