#!/bin/sh
case $1 in
  "up")
    xbacklight -inc 10
    ;;
  "down")
    xbacklight -dec 10
    ;;
  *)
    exit
    ;;
esac

brightness=$(xbacklight -get)

icon=$ICON_LOW
if [ $brightness -gt 80 ]; then
  icon=$ICON_HIGH
elif [ $brightness -gt 30 ]; then
  icon=$ICON_MID
fi

dunstify \
  -t 700 \
  -a "brightness" \
  -u low \
  -i $icon \
  -h int:value:"$brightness" \
  -r 100001 \
  "Brightness: ${brightness}%"

