#!/bin/bash

sudo pacman-db-upgrade
sudo pacman -S archlinux-keyring && sudo pacman -Syu

if [ ! -f /bin/tmux ];then
    sudo pacman -Syu --noconfirm
    sudo pacman -S --noconfirm go xterm zsh tmux git w3m net-tools gauche ctags lilyterm wpa_supplicant xsel xclip feh
fi

if [ ! -f /bin/nmap ];then
    sudo pacman -S --noconfirm nmap wireshark-cli aircrack-ng ufw
fi

if [ ! -f /bin/wine ];then
    sudo pacman -S --noconfirm wine winetricks
fi

if [ ! -f /bin/youtube-dl ];then
    sudo pacman -S --noconfirm youtube-dl
fi

if [ ! -f /usr/bin/yaourt ];then
    sudo pacman -Syu --noconfirm yaourt
    yaourt -Syu
    yaourt -S --noconfirm otf-ipaexfont
    yaourt -S --noconfirm nikto ophcrack john jdownloader2 go-mtpfs-git exfat-git atool virtualbox broadcom-wl-dkms ttyrec asciinema xf86-input-mtrack-git numix-icon-theme-git haroopad googlecl android-tools 
    #yaourt -S bulk_extractor edb-debugger nessus
    #yaourt -S packer
    #yaourt -S metasploit
    yaourt -S downgrade
fi

if [ ! -f /bin/blueman-applet ];then
    sudo pacman -S pulseaudio-alsa bluez bluez-libs bluez-utils bluez-firmware
    yaourt -S blueman pasystray-git pamixer-git pavucontrol 
fi

if [ ! -f /bin/startx ];then
    sudo pacman -S --noconfirm clamav gvim sysstat dstat iotop numix-themes ttf-dejavu xsel xclip vlc conky gparted arandr xorg xorg-xinit awesome vicious archlinux-themes-slim slim-themes slim spacefm vicious clipit udevil exfat-utils fuse-exfat ntfs-3g vlc xbindkeys alsa-utils xdotool xvkbd slop maim imagemagick ffmpeg mplayer inkscape gimp p7zip handbrake handbrake-cli gvfs qiv mcomix dwb chromium fcitx fcitx-im fcitx-configtool fcitx-mozc bluez bluez-utils xcompmgr keepassx firefox gthumb tumbler ffmpegthumbnailer file-roller rp-pppoe dnsmasq ferm perl-image-exiftool htop powertop zip tor
fi

#adobe
# yaourt -S ttf-ms-fonts
# yaourt -S flashplugin
# yaourt -S freshplayerplugin-git
# yaourt -S chromium-pepper-flash-dev
