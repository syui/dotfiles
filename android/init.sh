#!/bin/bash

if [ ! -f /bin/zsh ]; then
    #echo "CacheDir = /sdcard/pacman/cache/pkg/" >> /etc/pacman.conf
    #mkdir -p /sdcard/pacman/cache/pkg
    #rm -rf /var/cache/pacman/pkg
    pacman -Syu --noconfirm
    pacman-db-upgrade
    pacman -S --noconfirm zsh tmux vim git go base-devel
    pacman -Rc --noconfirm xorg
    pacman -Qdtq --noconfirm | pacman -Rs --noconfirm -
    pacman -Scc --noconfirm
    #sed -i 's/bash -i/zsh -i/g' $HOME/init.sh
    git clone http://github.com/syui/dotfiles $HOME/dotfiles
    ln -s $HOME/dotfiles/android/.zshrc $HOME/.zshrc
    zsh
fi
