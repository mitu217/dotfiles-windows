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

if has "fcitx-config-gtk3"; then
    log_pass "fctix_mozc: already installed"
    exit
fi

# https://qiita.com/yuta_vamdemic/items/3c14681311e5b326a4eb
wget -q https://www.ubuntulinux.jp/ubuntu-ja-archive-keyring.gpg -O- | sudo apt-key add -
wget -q https://www.ubuntulinux.jp/ubuntu-jp-ppa-keyring.gpg -O- | sudo apt-key add -
sudo wget https://www.ubuntulinux.jp/sources.list.d/bionic.list -O /etc/apt/sources.list.d/ubuntu-ja.list
sudo apt update
sudo apt -y upgrade
sudo apt install -y ubuntu-defaults-ja

sudo apt install -y fcitx fcitx-mozc

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export DefaultIMModule=fcitx

sudo apt install -y fonts-noto-cjk fonts-noto-color-emoji

sudo update-locale LANG=ja_JP.UTF8

fcitx-autostart
fcitx-config-gtk3

log_pass "fctix_mozc: installed successfully"
