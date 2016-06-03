#!/bin/zsh

bat=`cat /sys/class/power_supply/BAT0/capacity`
tmp=~/bin/battery.txt
icon=~/dotfiles/Pictures/icon/battery-low-48.png
title="Now Battery"
message="> $bat%"

i=5

if [ $bat -le 20 ];then
    notify-send.sh -t 0 -i $icon --replace=$i $title $message
elif [ $bat -le 10 ];then
    notify-send.sh -t 0 -i $icon --replace=$i $title $message
elif [ $bat -le 5 ];then
    notify-send.sh -t 0 -i $icon --replace=$i $title $message
    if [ "$1" = "-s" ] && [ -f /usr/share/sounds/speech-dispatcher/test.wav ];then
        mplayer /usr/share/sounds/speech-dispatcher/test.wav &
    fi
fi
