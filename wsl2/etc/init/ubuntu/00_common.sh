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

sudo apt update -y
sudo apt upgrade -y

log_pass "common: installed successfully"
