#!/bin/bash

#sudo systemctl enable netctl-auto
#sudo systemctl enable dhcpcd
sudo systemctl start bluetooth
sudo systemctl enable bluetooth
sudo systemctl start slim
sudo systemctl enable slim
sudo systemctl start dnsmasq
sudo systemctl enable dnsmasq
sudo systemctl start ufw
sudo systemctl enable ufw
#sudo netctl start extern0-profile
#sudo netctl enable extern0-profile
#sudo netctl start intern0-profile
#sudo netctl enable intern0-profile

