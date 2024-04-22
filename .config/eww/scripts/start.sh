#!/bin/bash

pkill eww
pkill -f notifications.py
eww daemon
eww open --screen 0 notifications_popup
eww open --screen 0 control_center
~/.config/eww/scripts/notifications.py &
