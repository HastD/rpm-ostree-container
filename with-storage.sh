#!/bin/sh

# SPDX-License-Identifier: Apache-2.0 OR MIT

storage_path=$1
shift

storage_conf='/etc/containers/storage.conf'
if ! [ -w "${storage_conf}" ]; then
    storage_conf="${XDG_CONFIG_HOME:-$HOME/.config}/containers/storage.conf"
fi

if [ -e "${storage_conf}" ]; then
    sudo sed -i --sandbox \
        -e "s|^graphroot[[:blank:]]*=.*|graphroot = \"${storage_path}\"|" \
        /etc/containers/storage.conf
else
    printf '[storage]\ngraphroot = "%s"\n' "${storage_path}" > "${storage_conf}"
fi

exec "$@"
