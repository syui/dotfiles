#!/bin/bash
su
# usb-efi-boot
mkdir -p /boot/efi
mount -t vfat /dev/sdb1 /boot/efi
if [ ! -d /boot/efi/EFI ];then
    pacman -S grub grub-efi-x86_64 efibootmgr --noconfirm
    grub-install --force --recheck --target=x86_64-efi --efi-directory=/boot/efi
    grub-mkconfig -o /boot/grub/grub.cfg
    cp /home/dotfiles/icon/arch-dark.volumeicon.icns /boot/efi/.volumeicon.icns
    mkdir -p /boot/efi/System/Library/CoreServices
    cp /boot/efi/EFI/arch/grubx64.efi /boot/efi/System/Library/CoreServices/Boot.efi
    echo 'HOOKS="base udev block autodetect modconf filesystems keyboard fsck"' >> /etc/mkinitcpio.conf
    mkinitcpio -p linux
fi
