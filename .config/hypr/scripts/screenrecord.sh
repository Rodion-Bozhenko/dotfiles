#!/bin/env bash

VID="${HOME}/Videos/$(date +%Y-%m-%d_%H-%m-%s).mp4"

wf-recorder_check() {
	if pgrep -x "wf-recorder" > /dev/null; then
			pkill -INT -x wf-recorder
      notify-send "Finish recording"
      wl-copy < "$(cat /tmp/recording.txt)"
			exit 0
	fi
}

wf-recorder_check


case $1 in
	"s")
		echo "$VID" > /tmp/recording.txt
		wf-recorder -g "$(slurp)" -f "$VID" &>/dev/null
		;;
	"f")
		echo "$VID" > /tmp/recording.txt
		wf-recorder -o eDP-1 -f "$VID" &>/dev/null
		;;
  *)
    ;;
esac
