#!/usr/bin/sh

HOMEPATH="${PREFIX}/${HOME}"

if [ ! -d "${HOMEPATH}/.config" ]
then
    mkdir "${HOMEPATH}/.config"
fi

if [ ! -d "${HOMEPATH}/.local" ]
then
    mkdir "${HOMEPATH}/.local"
    mkdir "${HOMEPATH}/.local/bin"
    mkdir "${HOMEPATH}/.local/share"
fi

if [ ! -d "${HOMEPATH}/.cache" ]
then
    mkdir "${HOMEPATH}/.cache"
fi
