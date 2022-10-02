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
    "Toolbox"
    "VcXsrv"
    "Tweeten"
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
