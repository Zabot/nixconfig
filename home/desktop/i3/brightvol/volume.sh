#!/bin/sh

sink=@DEFAULT_SINK@
case $1 in
  "up")
    pactl set-sink-mute $sink 0
    pactl set-sink-volume $sink +5%
    ;;
  "down")
    pactl set-sink-mute $sink 0
    pactl set-sink-volume $sink -5%
    ;;
  "mute")
    pactl set-sink-mute $sink toggle
    ;;
  *)
    exit
    ;;
esac

mute=$(pactl list sinks \
  | awk '/Mute: /{print $2}')

volume=$(pactl list sinks \
  | awk '/Volume: front-left/{print $5}' \
  | grep -o '[0-9]*')

icon=$ICON_MUTED
if [ "$mute" = "no" ]; then
  if [ $volume -gt 80 ]; then
    icon=$ICON_HIGH
  elif [ $volume -gt 30 ]; then
    icon=$ICON_MID
  else
    icon=$ICON_LOW
  fi

  aplay $SOUND_CHANGE_VOLUME &
fi

dunstify \
  -t 700 \
  -a "volume" \
  -u low \
  -i $icon \
  -h int:value:"$volume" \
  -r 100000 \
  "Volume: ${volume}%"

