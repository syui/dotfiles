#!/bin/zsh
dir=${0:a:h}
bat=`$dir/battery_current.sh`
# https://www.iconfinder.com/icons/379540/battery_charging_icon
ico=$dir/icon

##通知するバッテリーの残量
not=30
## テスト
#not=$((bat - 1))

while [ $bat -gt $not ]
do
    bat=`$dir/battery_current.sh`
    sleep 600
done

case $OSTYPE in
    darwin*)
        growlnotify -a Finder -m "Battery $bat %"
        ;;
    linux*)
        notify-send -i $ico/Battery-Charging-48.png "Battery `battery-info`"
        ;;
esac
