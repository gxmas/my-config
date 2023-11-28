#!/bin/sh

makedir () {
    local dstpath=$1

    if [ ! -d "${dstpath}" ]
    then
        echo "Create directory ${dstpath}"
        mkdir -p "${dstpath}"
    fi
}

copydir () {
    local srcpath="$1"
    local dstpath="$2"

    echo "Copy ${srcpath} to ${dstpath}"
    cp -r "${srcpath}" "${dstpath}"
}

if [ -z "${PREFIX}" ]
then
    CMD_SUDO="sudo"
fi

ETCPATH="${PREFIX%/}/etc"
HOMEPATH="${PREFIX%/}/${HOME#/}"
CONFIGPATH="${HOMEPATH}/.config"
LOCALPATH="${HOMEPATH}/.local"
CACHEPATH="${HOMEPATH}/.cache"

echo "CMD_SUDO: ${CMD_SUDO}"
echo
echo "PREFIX: ${PREFIX}"
echo "ETCPATH: ${ETCPATH}"
echo "HOMEPATH: ${HOMEPATH}"
echo "CONFIGPATH: ${CONFIGPATH}"
echo "LOCALPATH: ${LOCALPATH}"
echo "CACHEPATH: ${CACHEPATH}"

makedir "${ETCPATH}"
for etcdir in etc/*
do
    eval ${SUDO_CMD} copydir "${etcdir}" "${ETCPATH}"
done

makedir "${CONFIGPATH}"
for cfgdir in config/*
do
    copydir "${cfgdir}" "${CONFIGPATH}"
done

makedir "${LOCALPATH}"
makedir "${LOCALPATH}/bin"
makedir "${LOCALPATH}/share"

makedir "${CACHEPATH}"
