$WINGET_VERSION = "v1.3.2091"

try {
    Get-Command -Name winget -ErrorAction Stop
}
catch [System.Management.Automation.CommandNotFoundException] {
    Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/microsoft/winget-cli/releases/download/$WINGET_VERSION/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -OutFile winget-cli.msixbundle
    Add-AppxPackage winget-cli.msixbundle
    Remove-Item winget-cli.msixbundle
}
