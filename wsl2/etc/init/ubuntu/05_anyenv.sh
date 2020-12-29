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

# https://qiita.com/282Haniwa/items/71a48a10952413416d18

if !has "anyenv"; then
    git clone https://github.com/anyenv/anyenv ~/.anyenv
    exec $SHELL -l
    anyenv install --force-init
fi

if !has "goenv"; then
    anyenv install goenv
fi

log_pass "anyenv: installed successfully"
