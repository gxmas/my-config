#!/usr/bin/sh

# Required packages:
#   - libxss
#   - libxft
#   - picom
#   - alacritty
#   - ttf-firacode-nerd
#   - polybar

PREFIX=${PREFIX:-${HOME}}

echo "Copying Xorg config files to /etc/X11/xorg.conf.d/"
sudo cp etc/X11/xorg.conf.d /etc/X11/xorg.conf.d/

echo "Copying stack config file to ${PREFIX}/.config/stack"
cp -R config/stack ${PREFIX}/.config

echo "Copying XMonad config files to ${PREFIX}/.config/xmonad"
cp -R config/xmonad ${PREFIX}/.config

echo "Copying X11 config files to ${PREFIX}/.config/X11"
cp -R config/X11 ${PREFIX}/.config

echo "Copying alacritty config files to ${PREFIX}/.config/alacritty"
cp -R config/alacritty ${PREFIX}/.config

echo "Installing the Stack Haskell tool"
sudo curl -sSL https://get.haskellstack.org/ | sh
stack update

cd "${PREFIX}/.config/xmonad (tag v0.17.1)"
echo "Cloning xmonad"
git clone -b v0.17.1 https://github.com/xmonad/xmonad.git

echo "Cloning xmonad-contrib (tag v0.17.1)"
git clone -b v0.17.1 https://github.com/xmonad/xmonad-contrib.git

echo "Building XMonad"
stack build

echo "Building XMonad with configuration"
stack exec xmonad -- --recompile
