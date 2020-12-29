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

# homebrew
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
