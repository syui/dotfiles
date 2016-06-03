#!/bin/bash
img=archlinux.img
dir=/media/
size=3G

qemu-img resize $img $size
sudo losetup /dev/loop0 $img 
sudo mount -t ext4 /dev/loop0 /mnt
sudo resize2fs /dev/loop0 $size
