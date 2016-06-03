#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

#xrandr --output VIRTUAL1 --off --output eDP1 --mode 1366x768 --pos 0x0 --rotate normal --output DP1 --off --output HDMI2 --off --output HDMI1 --mode 1920x1080 --pos 1366x0 --rotate normal --output DP2 --off

# Configuration
xrdb -merge ~/.Xresources
exec syndaemon -t -k -i 2 -d  &

# Daemons
urxvtd -q -o -f &
unagi &
volnoti &
spacefm -d &
udevil &
conky &
VBoxClient-all &

# Applications
nm-applet &
volumeicon &
clipit &
#dropbox &
blueman-applet &
pasystray &
xcompmgr -n &

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
fcitx

#xmodmap ~/.xmodmap
exec kbdlight max &
exec xbindkeys &
exec i3

