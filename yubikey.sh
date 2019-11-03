sudo dhcpd
mkdir .gnupg

wget -P .gnupg https://raw.githubusercontent.com/drduh/config/master/gpg-agent.conf
wget -P .gnupg https://raw.githubusercontent.com/drduh/config/master/gpg.conf
chmod 600 .gnupg/gpg.conf

cat > .bashrc << EOF
  export GPG_TTY="$(tty)"
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  gpgconf --launch gpg-agent
EOF

source .bashrc
killall gpg-agent
gpg-connect-agent updatestartuptty /bye
source .bashrc

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
