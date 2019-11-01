#!/bin/bash

DISK="/dev/sda"
PARTITION="${DISK}1"

echo DISK="$DISK", PARTITION="$PARTITION"

parted -s $DISK mklabel gpt
parted -a optimal $DISK mkpart primary fat16 0% 5%
parted -a optimal $DISK mkpart primary ext4 5% 100%

sync

parted $DISK set 1 esp on 

mkfs.fat ${DEVICE}1
mkfs.ext4 -F "${DEVICE}2"

# you can find your closest server from: https://www.archlinux.org/mirrorlist/all/
echo 'Server = http://mirror.archlinux.no/$repo/os/$arch' > /etc/pacman.d/mirrorlist
mount "$PARTITION" /mnt
pacman -Syy

pacstrap /mnt $(pacman -Sqg base | sed 's/^linux$/&-lts/') base-devel grub openssh sudo ntp wget vim
genfstab -p /mnt >> /mnt/etc/fstab

cp ./chroot.sh /mnt
arch-chroot /mnt ./chroot.sh "$DISK"
umount -R /mnt
systemctl reboot
