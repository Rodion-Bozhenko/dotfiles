#!/usr/bin/env bash

state=$(~/bin/eww state)

if [[ $state == "" ]]
then 
  ~/bin/eww open --screen 0 dashboard
else
  ~/bin/eww close-all
fi
