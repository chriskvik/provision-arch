#!/bin/bash

curl -sL https://raw.githubusercontent.com/chriskvik/provision-arch/master/setup.sh > setup.sh
curl -sL https://raw.githubusercontent.com/chriskvik/provision-arch/master/chroot.sh > chroot.sh

chmod +x setup.sh chroot.sh

sh setup.sh
