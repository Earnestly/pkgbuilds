#!/bin/sh --
# locale.sh - set locale environments

# POSIX with local, supported by busybox sh and dash
# shellcheck disable=SC2039

fexport() {
    local k v
    while IFS='=' read -r k v; do
        case $k in
            LC_ALL) continue ;;
            LANG*|LC_*) export "$k"="$v"
        esac
    done
}

export LANG=C

# Override rather than overlay the system locale.conf if a user provided
# locale.conf is available.
if [ -s "${XDG_CONFIG_HOME:-$HOME/.config}"/locale.conf ]; then
    fexport < "${XDG_CONFIG_HOME:-$HOME/.config}"/locale.conf
elif [ -s /etc/locale.conf ]; then
    fexport < /etc/locale.conf
fi

unset -f fexport
