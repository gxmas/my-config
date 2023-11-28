#!/usr/bin/sh

# Expect the zsh package to be installed

PREFIX=${PREFIX:-${HOME}}

if [ ! -f /etc/zsh/zshenv ]
    echo "Copying zshenv to /etc/zsh/"
    sudo cp etc/zsh/zshenv /etc/zsh/zshenv
else
    echo "File /etc/zsh/zshenv already exists.  Not overwriting."
fi

echo "Installing the Zap plugin manager"
curl -sSL https://raw.githubusercontent.com/zap-zsh/zap/master/install.sh | sh

echo "Copying the zsh config files"
cp -R config/zsh ${PREFIX}/.config
