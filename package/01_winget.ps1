$WINGET_VERSION = "v1.3.2091"

try {
    Get-Command -Name winget -ErrorAction Stop
}
catch [System.Management.Automation.CommandNotFoundException] {
    # install Microsoft.VCLibs
    Invoke-WebRequest -UseBasicParsing -Uri "https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx" -OutFile Microsoft.VCLibs.x64.appx
    Add-AppxPackage Microsoft.VCLibs.x64.appx
    Remove-Item Microsoft.VCLibs.x64.appx
    
    # install Microsoft.UI.Xaml
    # ref: https://github.com/microsoft/winget-cli/issues/1861
    Invoke-WebRequest -UseBasicParsing -Uri "https://www.nuget.org/api/v2/package/Microsoft.UI.Xaml/2.7.0" -OutFile microsoft.ui.xaml.zip
    Expand-Archive -Path microsoft.ui.xaml.zip microsoft.ui.xaml
    Add-AppxPackage microsoft.ui.xaml\tools\AppX\x64\Release\Microsoft.UI.Xaml.2.7.appx

    # running
    Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/microsoft/winget-cli/releases/download/$WINGET_VERSION/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle" -OutFile winget-cli.msixbundle
    Add-AppxPackage winget-cli.msixbundle
    Remove-Item winget-cli.msixbundle
}
