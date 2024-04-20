#!/bin/bash

pkill eww
pkill -f notifications.py
eww daemon
eww open --screen 0 notifications_popup
~/.config/eww/scripts/notifications.py &
