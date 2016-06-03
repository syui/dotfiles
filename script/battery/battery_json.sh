#!/bin/zsh
case $OSTYPE in
    darwin*)
ioreg -c AppleSmartBatteryioreg -c AppleSmartBattery | grep -i LegacyBatteryInfo | cut -d = -f 2- | sed 's/=/:/g'
;;
    linux*)
        dire="/sys/class/power_supply/BAT0/"
        file=`ls -AF $dire | grep -v /`
        #info=`cat $dire{$(ls -AFm $dire | grep -v / | tr -d '\n')}`
        info=`cat $dire{current_avg,cycle_count,manufacturer,model_name,present,status,technology,type,uevent,voltage_min_design,voltage_now}`

        echo "{"
        for (( i=1; i<=`echo $file | wc -l|tr -d ' '`; i++ ))
        do
            numb=`echo $file | awk "NR==$i"`
            item=`echo $info | awk "NR==$i"`
            echo $numb : $item ,
        done
        echo -e "uname : `uname -rm`\n}"
        ;;
esac

