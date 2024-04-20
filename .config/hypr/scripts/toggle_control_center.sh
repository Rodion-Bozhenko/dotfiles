#!/usr/bin/env bash

opened=$(~/bin/eww get control_center_opened)

if [[ $opened = false ]]
then 
  ~/bin/eww update control_center_opened=true
  ~/bin/eww open --screen 0 control_center
else
  ~/bin/eww update control_center_opened=false
  ~/bin/eww close control_center
fi
