#!/usr/bin/env bash

declare -a profiles_photos=("$HOME/Pictures/shibainu.jpg")

for pfp in ${profiles_photos[@]}; do
  if test -f $pfp; then
    echo $pfp
    exit 0
  fi
done

echo $HOME/.config/dk/eww/assets/default-pfp.png
