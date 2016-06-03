#!/bin/zsh

case $OSTYPE in
    darwin*)
        com="ioreg -c AppleSmartBatteryioreg -c AppleSmartBattery | grep -i LegacyBatteryInfo | cut -d , -f"
        sum=3
        max=`eval $com $sum | cut -d = -f 2`
        sum=4
        cur=`eval $com $sum | cut -d = -f 2`
        echo "scale=3; $cur / $max * 100" | bc | cut -d . -f 1
    ;;

    linux*)
        com=`cat /sys/class/power_supply/BAT0/capacity`
        echo $com
        ;;
esac
