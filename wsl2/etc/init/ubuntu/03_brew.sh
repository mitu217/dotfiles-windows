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

if has "brew"; then
    log_pass "brew: already installed"
    exit
fi

# https://brew.sh/index_ja
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


sudo apt-get install build-essential
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
brew install gcc

log_pass "brew: installed successfully"
