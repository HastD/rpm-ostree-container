#!/bin/sh

# SPDX-License-Identifier: Apache-2.0 OR MIT

set -eu

case $1 in
    --storage)
        shift
        storage_path=$1
        shift
        ;;
    --storage=*)
        storage_path=${1#--storage=}
        shift
        ;;
esac

if [ -n "${storage_path:-}" ]; then
    storage_conf_file='/etc/containers/storage.conf'
    if ! [ -w "${storage_conf_file}" ]; then
        storage_conf_file="${XDG_CONFIG_HOME:-$HOME/.config}/containers/storage.conf"
    fi

    if [ -e "${storage_conf_file}" ]; then
        sed -i --sandbox \
            -e "s|^graphroot[[:blank:]]*=.*|graphroot = \"${storage_path}\"|" \
            /etc/containers/storage.conf
    else
        printf '[storage]\ngraphroot = "%s"\n' "${storage_path}" > "${storage_conf_file}"
    fi
fi

exec "$@"
