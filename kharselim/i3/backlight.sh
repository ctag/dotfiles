#!/bin/bash

brightness=/sys/class/backlight/intel_backlight/brightness
current=`cat /sys/class/backlight/intel_backlight/brightness`

if [ "$1" == "set" ]; then
    echo "$2" > $brightness
elif [ "$1" == "inc" ]; then
    new=`echo "${current}+${2}" | bc`
    echo "$new" > $brightness
elif [ "$1" == "dec" ]; then
    new=`echo "${current}-${2}" | bc`
    echo "$new" > $brightness
fi
