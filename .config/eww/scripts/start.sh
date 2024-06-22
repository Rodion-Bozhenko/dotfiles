#!/bin/bash

pkill eww
pkill -f notifications.py
~/bin/eww daemon
~/bin/eww open --screen 0 notifications_popup
~/bin/eww open --screen 0 control_center
~/.config/eww/scripts/notifications.py &
