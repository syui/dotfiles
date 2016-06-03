#!/bin/bash

### user {{{
if [ ! -f /etc/hostname ];then

pacman -Sy sudo --noconfirm
echo macbook > /etc/hostname
useradd -m -G wheel -s /bin/bash syui
passwd
passwd syui

cat << EOF >> /etc/locale.gen
en_US.UTF-8 UTF-8
ja_JP.UTF-8 UTF-8
EOF

touch /etc/locale.conf
cat << EOF >> /etc/locale.conf
LANG=ja_JP.UTF-8
EOF
locale-gen

ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
hwclock --systohc --utc

touch /etc/sudoers
cat << EOF >> /etc/sudoers
Defaults env_keep += "HOME"
%wheel ALL=(ALL) ALL
EOF

cat << EOF >> /etc/pacman.conf
[archlinuxfr]
SigLevel = Never
EOF
echo 'Server = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf
pacman -Syu --noconfirm
pacman -S zsh git --noconfirm
git clone http://github.com/syui/dotfiles /home/syui/dotfiles
chsh

fi
### }}}

## theme {{{
chsh -s /bin/zsh

if [ ! -f ~/.config/fontconfig/font.conf ];then
    ln -s ~/dotfiles/.config/fontconfig/font.conf ~/.config/fontconfig/font.conf
#mkdir -p ~/.config/fontconfig
#touch ~/.config/fontconfig/font.conf
#cat << EOF >> ~/.config/fontconfig/font.conf
#<?xml version="1.0"?>
#<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
#<fontconfig>
#  <match target="font">
#    <edit mode="assign" name="embeddedbitmap">
#      <bool>false</bool>
#    </edit>
#    <edit mode="assign" name="hintstyle">
#       <const>hintnone</const>
#    </edit>
#  </match>
#</fontconfig>
#EOF
fi



## icon, theme
case $OSTYPE in
    linux*)
        if [ ! -d /usr/share/icons/Numix ];then
            yaourt -S numix-icon-theme-git
        fi
        
        if [ ! -d /usr/share/themes/Numix ];then
            pacman -S --noconfirm numix-themes
        fi

        if [ ! -f ~/.gtkrc-2.0 ];then
            ln -s ~/dotfiles/.gtkrc-2.0 ~/.gtkrc-2.0
#cat << EOF > ~/.gtkrc-2.0
#gtk-icon-theme-name = "Numix"
#gtk-theme-name = "Numix"
#gtk-font-name = "DejaVu Sans 13"
#EOF
        fi
#
        if [ ! -d $HOME/.config/gtk-3.0 ];then
            ln -s ~/dotfiles/.config/gtk-3.0 ~/.config/gtk-3.0
#mkdir -p ~/.config/gtk-3.0
#cat << EOF > ~/.config/gtk-3.0/settings.ini
##gtk-icon-theme-name = "Default"
#gtk-icon-theme-name = "Numix-Light"
#gtk-theme-name = "Numix"
#gtk-font-name = "DejaVu Sans 13"
#EOF
            sudo gtk-update-icon-cache -f /usr/share/icons/Numix
        fi
#;;
#esac

##awesome-theme
case $OSTYPE in
    linux*)
        if [ ! -d $HOME/.config/awesome/powerarrow-dark ];then
            #git clone https://github.com/bioe007/awesome-revelation ~/.config/awesome/revelation
            git clone https://github.com/syui/powerarrow-dark ~/dotfiles/.config/awesome/powerarrow-dark
            cd ~/dotfiles/.config/awesome/powerarrow-dark
            cp -R awesome/ ~/.config
fi
;;
esac

#su -
#
if [ -d /etc/slim.conf ];then
sudo cat << EOF >> /etc/slim.conf
default_user syui
auto_login yes
daemon yes
EOF
fi

#if [ -f /etc/xdg/share/.xinitrc ];then
#    cp -i /etc/xdg/share/.xinitrc ~/
#fi

if [ ! -f /etc/vconsole.conf ];then
    ln -s ~/dotfiles/etc/vconsole.conf /etc/vconsole.conf
##cat << EOF >> /etc/vconsole.conf
##FONT=DejaVu 
##FONTMAP=DejaVu
##KEYMAP=jp106
##EOF
fi

#cp -i /etc/xdg/share/.xinitrc ~/
#echo "xcompmgr -n &" >> ~/.xinitrc
#echo "exec awesome" >> .xinitrc
#
#cat << EOF >> ~/.xinitrc
#export GTK_IM_MODULE=fcitx
#export QT_IM_MODULE=fcitx
#export XMODIFIERS="@im=fcitx"
#fcitx
#EOF

#xset dpms 0 0 0;xset s off
#xset s off
#xset dpms 0 0 0

sudo cp ~/dotfiles/etc/X11/xorg.conf.d/* /etc/X11/xorg.conf.d

sudo timedatectl set-timezone Asia/Tokyo
sudo locale-gen
# }}}


