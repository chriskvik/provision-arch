#!/bin/bash

curl -sL https://raw.githubusercontent.com/chriskvik/provision-arch/master/setup.sh > setup.sh
curl -sL https://raw.githubusercontent.com/chriskvik/provision-arch/master/chroot.sh > chroot.sh
curl -sL https://raw.githubusercontent.com/chriskvik/provision-arch/master/firstboot.sh > firstboot.sh

chmod +x setup.sh chroot.sh firstboot.sh

DISC=/dev/sda DISC1=/dev/sda1 DISC2=/dev/sda2 USERNAME=christian HOSTNAME=arch ./setup.sh
