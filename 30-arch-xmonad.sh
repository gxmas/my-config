#!/usr/bin/sh

# Required packages:
#   - libxss
#   - libxft
#   - picom
#   - alacritty
#   - ttf-firacode-nerd
#   - polybar

CMD_SUDO="${PREFIX:+sudo}"

HOMEPATH="${PREFIX}/home/${USER}"
CONFIGPATH="${HOMEPATH}/.config"

echo "Copying Xorg config files to /etc/X11/xorg.conf.d/"
${CMD_SUDO} cp etc/X11/xorg.conf.d ${PREFIX}/etc/X11/xorg.conf.d/

echo "Copying stack config file to ${CONFIGPATH}/stack"
cp -r config/stack ${CONFIGPATH}

echo "Copying XMonad config files to ${CONFIGPATH}/xmonad"
cp -r config/xmonad ${CONFIGPATH}

echo "Copying X11 config files to ${CONFIGPATH}/X11"
cp -r config/X11 ${CONFIGPATH}

echo "Copying alacritty config files to ${CONFIGPATH}/alacritty"
cp -r config/alacritty ${CONFIGPATH}

echo "Installing the Stack Haskell tool"
sudo curl -sSL https://get.haskellstack.org/ | sh
stack upgrade
stack update

cd "${CONFIGPATH}/xmonad (tag v0.17.1)"
echo "Cloning xmonad"
git clone -b v0.17.1 https://github.com/xmonad/xmonad.git

echo "Cloning xmonad-contrib (tag v0.17.1)"
git clone -b v0.17.1 https://github.com/xmonad/xmonad-contrib.git

echo "Building XMonad"
stack build

echo "Building XMonad with configuration"
stack exec xmonad -- --recompile
