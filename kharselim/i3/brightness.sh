#!/bin/bash

# ensure running as root
if [ "$(id -u)" != "0" ]; then
  exec sudo "$0" "$@" 
fi

BRIGHTNESS=`cat /sys/class/backlight/intel_backlight/brightness`

BRIGHTNESS=$(($BRIGHTNESS $1 $2))

if [ $BRIGHTNESS -lt 0 ]; then
	BRIGHTNESS=0
fi

echo $BRIGHTNESS > /sys/class/backlight/intel_backlight/brightness

#echo $BRIGHTNESS
