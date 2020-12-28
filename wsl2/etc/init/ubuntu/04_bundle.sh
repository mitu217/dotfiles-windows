#!/bin/bash

# Stop script if errors occur
trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -eu

if [ -z "$DOTPATH" ]; then
    # shellcheck disable=SC2016
    echo '$DOTPATH not set' >&2
    exit 1
fi

# Load vital library that is most important and
# constructed with many minimal functions
. "$DOTPATH"/wsl2/etc/lib/vital.sh

# install JetBrakns ToolBox
curl -L "https://download.jetbrains.com/toolbox/jetbrains-toolbox-1.19.7784.tar.gz" --insecure | sudo tar zx -C /usr/local/bin --strip-components 1

log_pass "bundle: installed successfully"