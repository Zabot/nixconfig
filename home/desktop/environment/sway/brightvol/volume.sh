#!/bin/sh

sink=@DEFAULT_SINK@
case $1 in
  "up")
    wpctl set-mute $sink 0
    wpctl set-volume $sink 5%+
    ;;
  "down")
    wpctl set-mute $sink 0
    wpctl set-volume $sink 5%-
    ;;
  "mute")
    wpctl set-mute $sink toggle
    ;;
  *)
    exit
    ;;
esac

mute=$(wpctl get-volume $sink | grep -o MUTED)
volume=$(wpctl get-volume $sink | grep -P -o '(?<=0.)[0-9]*')

icon=$ICON_MUTED
if [ "$mute" != "MUTED" ]; then
  if [ $volume -gt 80 ]; then
    icon=$ICON_HIGH
  elif [ $volume -gt 30 ]; then
    icon=$ICON_MID
  else
    icon=$ICON_LOW
  fi

  pw-cat -p $SOUND_CHANGE_VOLUME &
fi

dunstify \
  -t 700 \
  -a "volume" \
  -u low \
  -i $icon \
  -h int:value:"$volume" \
  -r 100000 \
  "Volume: ${volume}%"

