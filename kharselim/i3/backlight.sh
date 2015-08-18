#!/bin/bash

brightness=/sys/class/backlight/intel_backlight/brightness
max_brightness=/sys/class/backlight/intel_backlight/max_brightness
current=`cat /sys/class/backlight/intel_backlight/brightness`

if [ "$1" == "set" ]; then
    echo "$2" > $brightness
elif [ "$1" == "inc" ]; then
    new=`echo "${current}+${2}" | bc`
    if [ "$new" -gt "$max_brightness" ]; then
        new=$max_brightness
    fi
    echo "$new" > $brightness
elif [ "$1" == "dec" ]; then
    new=`echo "${current}-${2}" | bc`
    if [ "$new" -lt "0" ]; then
        new=0
    fi
    echo "$new" > $brightness
fi
