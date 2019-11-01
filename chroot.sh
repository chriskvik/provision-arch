#!/bin/bash

HOST=arch
USERNAME=christian
HOME_DIR="/home/${USERNAME}"
SWAP_SIZE=4G

# grub as a bootloader
grub-install --target=i386-pc --recheck "$1"

# This makes the grub timeout 0, it's faster than 5 :)
sudo sed -i 's/GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

# run these following essential service by default
systemctl enable sshd.service
systemctl enable dhcpcd.service
systemctl enable ntpd.service

echo "$HOST" > /etc/hostname

# inject vimrc config to default user dir if you like vim
echo -e 'runtime! archlinux.vim\nsyntax on' > /etc/skel/.vimrc

# adding your normal user with additional wheel group so can sudo
useradd -m -G wheel -s /bin/bash "$USERNAME"

# adjust your timezone here
ln -f -s /usr/share/zoneinfo/Norway/Oslo /etc/localtime
hwclock --systohc

# adjust your name servers here if you don't want to use google
echo 'name_servers="8.8.8.8 8.8.4.4"' >> /etc/resolvconf.conf
echo en_US.UTF-8 UTF-8 > /etc/locale.gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
locale-gen


# creating the swap file, if you have enough RAM, you can skip this step
fallocate -l "$SWAP_SIZE" /swapfile
chmod 600 /swapfile
mkswap /swapfile
echo /swapfile none swap defaults 0 0 >> /etc/fstab

# auto-complete these essential commands
echo complete -cf sudo >> /etc/bash.bashrc
echo complete -cf man >> /etc/bash.bashrc
