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

# https://qiita.com/yuta_vamdemic/items/3c14681311e5b326a4eb
sudo service dbus start
sudo apt install ubuntu-mate-desktop mate-desktop-environment mate-common mate-core

# https://qiita.com/nishemon/items/bb3aca972404f68bfcd6
sudo ln -s /mnt/c/Windows/Fonts /usr/share/fonts/windows
sudo fc-cache -fv

log_pass "x server: installed successfully"
