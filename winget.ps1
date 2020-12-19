# Install winget
if (Get-Command winget -errorAction SilentlyContinue)
{
    "already installed $WINGET_COMMAND"
}
else
{
    wget https://github.com/microsoft/winget-cli/releases/download/v0.2.2941-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle > winget-cli.appbundle
    Add-AppPackage winget-cli.appbundle
    rm winget-cli.appbundle
}
