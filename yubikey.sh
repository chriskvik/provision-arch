sudo dhcpd

wget -P /home/$USERNAME/.gnupg https://raw.githubusercontent.com/drduh/config/master/gpg-agent.conf
wget -P /home/$USERNAME/.gnupg https://raw.githubusercontent.com/drduh/config/master/gpg.conf
chmod 600 /home/christian/.gnupg/gpg.conf

cat > .bashrc << EOF
  export GPG_TTY="$(tty)"
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  gpgconf --launch gpg-agent
EOF

source /home/$USERNAME/.bashrc
killall gpg-agent
gpg-connect-agent updatestartuptty /bye

# clone dotfiles
# su $USERNAME -l << EOF
#  cd ~
#  git init
#  git remote add origin git@github.com:chriskvik/dotfiles-arch.git
#  #git clean -f
#  git pull origin master
#EOF

# run provision
#cd ~$USERNAME/.install
#make install

# TODO: kill dhcpcd
#poweroff
