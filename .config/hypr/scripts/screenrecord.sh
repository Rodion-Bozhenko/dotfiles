#!/bin/env bash

VID="${HOME}/Videos/Screencast/$(date +%Y-%m-%d_%H-%m-%s).mp4"
THUMB="${HOME}/Videos/Screencast/thumb.png"

wf-recorder_check() {
	if pgrep -x "wf-recorder" > /dev/null; then
        notify-send "CHECK"
        pkill -INT -x wf-recorder
        vid="$(cat /tmp/recording.txt)"
        ffmpeg -i "$vid" -ss 00:00:01 -vframes 1 "$THUMB" 2> "${HOME}/ffmpeg_errors.log"
        sleep 1
        notify-send "$vid"
        notify-send "Finish recording" -i "$THUMB"
        rm "$THUMB"
        wl-copy "$vid"
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
