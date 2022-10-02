winget source update
$WINGET_PACKAGES = @(
    "AgileBits.1Password"
    "Discord.Discord"
    "SlackTechnologies.Slack"
    "Fork.Fork"
    "Canonical.Ubuntu.2004"
    "Microsoft.VisualStudioCode"
    "SublimeHQ.SublimeText.4"
    "Google.Chrome"
    "Git.Git"
)
foreach($PACKAGE in $WINGET_PACKAGES){
    # Returns a Boolean value by Quiet option
    if (winget list | Select-String -Pattern $PACKAGE -Quiet)
    {
        "$PACKAGE already installed"
    }
    else
    {
        winget install -e --id  $PACKAGE --accept-package-agreements --accept-source-agreements -h
    }
}
