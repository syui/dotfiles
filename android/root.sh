#!/bin/zsh

# type:nexus7-2013-wifi-flo
# conect:nexus7-usb-pc

# update {{{
# https://developers.google.com/android/nexus/images
curl -O https://dl.google.com/dl/android/aosp/razor-lrx22g-factory-bff2093e.tgz
tar zxvf razor-lrx22g-fact
cd razor-lrx22g/
#./flash-all.sh
unzip image-razor-lrx22g.zip
adb device
adb reboot-bootloader
sleep 4
#fastboot oem unlock
fastboot flash boot boot.img
fastboot erase system
fastboot flash system system.img

# custom-recovery
# http://teamw.in/project/twrp2
# fastboot boot openrecovery-twrp-2.8.5.0-flo.img
fastboot reboot
# }}}

# root {{{
# http://autoroot.chainfire.eu/
curl -L http://download.chainfire.eu/347/CF-Root1/CF-Auto-Root-flo-razor-nexus7.zip?retrieve_file=1 -o ./CF-Auto-Root-flo-razor-nexus7.zip
unzip CF-Auto-Root-flo-razor-nexus7.zip
adb device
adb reboot-bootloader
sleep 4
case $OSTYPE in
    linux*)
        chmod +x root-linux.sh 
        ./root-linux.sh 
    ;;
    darwin*)
        chmod +x root-mac.sh 
        ./root-mac.sh 
    ;;
    cygwin*|msys*)
        chmod +x root-windows.bat 
        ./root-windows.bat 
    ;;
esac
# }}}

# other {{{
#adb reboot recovery
#adb reboot
#fastboot reboot
#fastboot boot openrecovery-twrp-2.8.5.0-flo.img
#adb shell vdc volume list
#adb shell mount
#adb shell mount -o rw,remount /system
# }}}
