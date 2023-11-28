#!/usr/bin/sh

PREFIX=${PREFIX:-${HOME}}

if [ ! -d "${PREFIX}/.config" ]
then
    mkdir "${PREFIX}/.config"
fi

if [ ! -d "${PREFIX}/.local" ]
then
    mkdir "${PREFIX}/.local"
    mkdir "${PREFIX}/.local/bin"
    mkdir "${PREFIX}/.local/share"
fi

if [ ! -d "${PREFIX}/.cache" ]
then
    mkdir "${PREFIX}/.cache"
fi
