#!/bin/bash
#export DISPLAY=:0.0
#export XAUTHORITY=/home/syui/.Xauthority
export battery_level=`cat /sys/class/power_supply/BAT0/capacity`
export battery_status=`cat /sys/class/power_supply/BAT0/status`

##test {{{
#if [ "$battery_status" = "Charging" ];then
#    if [ $battery_level -le 5 ];then
#        sudo -u syui notify-send -u critical -i /usr/share/icons/Numix/24x24/status/battery-000-charging.svg "Battery level is ${battery_level}%!" 
#    elif [ $battery_level -le 100 ];then
#        sudo -u syui notify-send -u critical -i /usr/share/icons/Numix/24x24/status/battery-000-charging.svg "Battery level is ${battery_level}%!" 
#        #notify-send -i /usr/share/icons/Numix/24x24/status/battery-000-charging.svg "Battery level is ${battery_level}%!"
#    fi
#fi
## }}}

if [ "$battery_status" = "Discharging" ];then
    if [ $battery_level -le 5 ];then
        notify-send -u critical -i /usr/share/icons/Numix/24x24/status/battery-000-charging.svg "Battery level is ${battery_level}%!" 
    elif [ $battery_level -le 10 ];then
        notify-send -i /usr/share/icons/Numix/24x24/status/battery-000-charging.svg "Battery level is ${battery_level}%!"
    fi
fi
