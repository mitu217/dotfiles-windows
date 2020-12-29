# ssh-key
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa

# start VcXsrv
if ! tasklist.exe | grep vcxsrv.exe > /dev/null ; then
  "/mnt/c/Program Files/VcXsrv/vcxsrv.exe" :0 -multiwindow -clipboard -noprimary -wgl > /dev/null 2>&1 & 
fi

# x server
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0

# fcitx-mozc
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export DefaultIMModule=fcitx

# anyenv
if [ -e "$HOME/.anyenv" ]
then
    export ANYENV_ROOT="$HOME/.anyenv"
    export PATH="$ANYENV_ROOT/bin:$PATH"
    if command -v anyenv 1>/dev/null 2>&1
    then
        eval "$(anyenv init -)"
    fi
fi
