#!/bin/bash

set -e

## URLs
GIT_URL="git@github.com:Mitu217/dotfiles-windows.git"
ARCHIVE_URL="https://github.com/Mitu217/dotfiles-windows/archive/main.tar.gz"

## Paths
USERNAME=`cmd.exe /c echo %username% | sed -e 's/\\r//g'`
DOTFILES=".bashrc .bash_profile"
DOTFILE_DIR="${HOME}/dotfiles"
SSHFILES="id_rsa id_rsa.pub"
SSHFILE_SRC_DIR="/mnt/c/Users/${USERNAME}/.ssh"
SSHFILE_DST_DIR="${HOME}/.ssh"

has() {
  type "$1" > /dev/null 2>&1
}

# download dotfiles
if [ ! -d ${DOTFILE_DIR} ]; then
  echo "==> Downloading dotfiles..."
  echo ''
  mkdir ${DOTFILE_DIR} && \
    curl -L ${ARCHIVE_URL} --insecure | tar zx -C ${DOTFILE_DIR} --strip-components 1
  echo $(tput setaf 2)Download dotfiles complete!. ✔︎$(tput sgr0)
  echo ''
fi

# deploy dotfiles
cd ${DOTFILE_DIR}
echo '==> Start to deploy dotfiles to home directory'
echo ''
for val in ${DOTFILES}
do
  ln -sfnv ${DOTFILE_DIR}/wsl2/dotfiles/${val} ${HOME}/${val}
done
echo ''
echo $(tput setaf 2)Deploy dotfiles complete!. ✔︎$(tput sgr0)
echo ''

# deploy ssh_key
cd ${SSHFILE_DIR}
echo '==> Start to deploy sshfiles to home directory'
echo ''
for val in ${SSHFILES}
do
  ln -sfnv ${SSHFILE_SRC_DIR}/${val} ${SSHFILE_DST_DIR}/${val}
done
echo ''
echo $(tput setaf 2)Deploy sshfiles complete!. ✔︎$(tput sgr0)
echo ''

# initialize
echo '==> Start to initialize'
echo ''
DOTPATH=${DOTFILE_DIR} bash ${DOTFILE_DIR}/wsl2/etc/init/init.sh
echo ''
echo $(tput setaf 2)initialize complete!. ✔︎$(tput sgr0)
echo ''