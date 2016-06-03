#!/bin/bash

### startup {{{
if [ ! -d /boot ];then
    loadkeys jp106

    echo "[sda1:200M-300M:vfat], [sda2:90%:ext4], [sda3:10%:none]"

    fdisk -l
    echo disk:
    read disk
    cfdisk /dev/$disk

    mkfs.vfat /dev/${disk}1
    mkfs.ext4 /dev/${disk}2

    mount /dev/${disk}2 /mnt

    mv /etc/pacman.d/mirrorlist /
    echo `cat /mirrorlist | grep .jp` > /etc/pacman.d/mirrorlist
    cat /mirrorlist >> /etc/pacman.d/mirrorlist

    pacstrap /mnt base base-devel

    genfstab -U -p /mnt >> /mnt/etc/fstab

    arch-chroot /mnt
    pacman-db-upgrade
    #pacman -S grub dosfstools efibootmgr os-prober
    pacman -S grub grub-efi-x86_64 --noconfirm
    grub-install --force --recheck /dev/sda
    # mount /dev/sda1 /mnt
    # grub-install --force --recheck --efi-directory=/mnt /dev/sda
    grub-mkconfig -o /boot/grub/grub.cfg
    #pacman -S wireless_tools wpa_supplicant wpa_actiond dialog ifplugd --noconfirm
    #systemctl enable netctl-auto@wlp2s0
    systemctl enable dhcpcd.service

    exit
    umount -R /mnt
    reboot
fi
### }}}
