#!/bin/bash

if [ ! -f /etc/netctl/pppoe ];then
    sudo cp /etc/netctl/examples/pppoe /etc/netctl/
fi

sudo pacman -Qet
sudo pacman -Qm

sudo ufw allow http
sudo ufw allow tftp
sudo ufw allow bonjour
sudo ufw allow 67/udp
sudo ufw allow 68/udp
