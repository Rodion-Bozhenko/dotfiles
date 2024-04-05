#!/usr/bin/env sh

if pgrep -x "wlogout" > /dev/null
then
    pkill -x "wlogout"
    exit 0
fi

ScrDir=`dirname "$(realpath "$0")"`
source $ScrDir/globalcontrol.sh
layout="${XDG_CONFIG_HOME:-$HOME/.config}/wlogout/layout"
style="${XDG_CONFIG_HOME:-$HOME/.config}/wlogout/style.css"

wlStyle=`envsubst < $style`

# launch wlogout
wlogout -b 2 -c 0 -r 0 -m 0 --layout $layout --css <(echo "$wlStyle") --protocol layer-shell

