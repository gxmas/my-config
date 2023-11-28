#!/usr/bin/sh

# Expect the zsh package to be installed

CMD_SUDO="${PREFIX:+sudo}"

HOMEPATH="${PREFIX}/${HOME}"
CONFIGPATH="${HOMEPATH}/.config"

if [ ! -f "${PREFIX}/etc/zshenv" ]
then
    echo "Copying zshenv to ${PREFIX}/etc"
    eval ${SUDO_CMD} cp etc/zshenv "${PREFIX}/etc/zshenv"
else
    echo "File ${PREFIX}/etc/zshenv already exists.  Not overwriting."
fi

echo "Installing the Zap plugin manager"
curl -sSL https://raw.githubusercontent.com/zap-zsh/zap/master/install.sh | sh

echo "Copying the zsh config files"
cp -r config/zsh "${CONFIGPATH}"
