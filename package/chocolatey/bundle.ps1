# DO NOT RUN WITH NON-ADMINISTRATOR

try {
    Get-Command -Name choco -ErrorAction Stop
}
catch [System.Management.Automation.CommandNotFoundException] {
    # https://chocolatey.org/install
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# using magic trackpad for windows (https://github.com/imbushuo/mac-precision-touchpad)
choco install -y mac-precision-touchpad