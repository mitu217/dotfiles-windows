$WINGET_COMMAND = "winget"
$WINGET_VERSION = "v0.2.2941-preview"

# Install winget
if (Get-Command $WINGET_COMMAND -errorAction SilentlyContinue)
{
    "already installed `$WINGET_COMMAND`"
}
else
{
    $APPBUNDLE_PATH = "winget-cli.appbundle"
    wget https://github.com/microsoft/winget-cli/releases/download/$WINGET_VERSION/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle > $APPBUNDLE_PATH
    Add-AppPackage winget-cli.appbundle
    rm $APPBUNDLE_PATH
}
