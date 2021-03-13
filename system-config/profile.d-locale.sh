#!/bin/sh --
# locale.sh - set locale environments

fexport() {
    while IFS='=' read -r k v; do
        case $k in
            LC_ALL) ;;
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

unset k v
unset -f fexport
