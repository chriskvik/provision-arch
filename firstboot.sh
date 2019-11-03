#!/bin/bash
# shellcheck disable=SC2086
set -exuo pipefail

loadkeys no

# don't automatically re-execute if something goes wrong
rm -rf /root/.profile

# disable autologin
systemctl disable getty\@tty1.service.d
rm -rf /etc/systemd/system/getty\@tty1.service.d

dhcpcd && sleep 10

# localectl
pacman -S --noconfirm libxkbcommon-x11
localectl set-locale LANG=en_GB.UTF-8

# include multilib
sed -i 's/^#\[multilib\]/[multilib]\nInclude = \/etc\/pacman.d\/mirrorlist/' /etc/pacman.conf
pacman -Syy
pacman -Syu

# install sudo and add wheel group to sudoers
pacman -S --noconfirm  sudo
sed -i '/^# %wheel ALL=(ALL) ALL$/ s/^# //' /etc/sudoers
visudo -cf /etc/sudoers


echo Username?
read USERNAME
echo Password?
read PASSWORD

# set password for root and new user
yes "$PASSWORD" | passwd || :
useradd -m -g users -G audio,games,rfkill,uucp,video,wheel -s /bin/bash $USERNAME
yes "$PASSWORD" | passwd $USERNAME || :

# install requirements for provision
sudo pacman -Syu gnupg2 pcsclite ccid hopenpgp-tools yubikey-personalization acsccid wget openssh
sudo systemctl enable pcscd.service
sudo systemctl start pcscd.service 

