# install winget
# not needed once winget is released
if (Get-Command winget -errorAction SilentlyContinue)
{
    "already installed winget"
}
else
{
    Invoke-WebRequest -UseBasicParsing -Uri https://github.com/microsoft/winget-cli/releases/download/v0.2.2941-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle -OutFile winget-cli.appbundle
    Add-AppPackage winget-cli.appbundle
    Remove-Item winget-cli.appbundle
}

# install packages
$WINGET_PACKAGES = @(
  "1password"  
)
winget install --silent $WINGET_PACKAGES
