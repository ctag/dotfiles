#!/bin/bash

value=$(xrandr -d :0.0 --verbose | grep Brightness | awk '{ print $2 }')
echo $value
value=$(echo "$value - 0.10" | bc)
echo $value

if [ $(echo "$value < 0.20" | bc) = "1" ]; then
value=0.20
fi

echo $value
xrandr -d :0.0 --output DVI-I-1 --brightness $value
xrandr -d :0.2 --output DVI-I-1 --brightness $value
xrandr -d :0.1 --output DVI-D-0 --brightness $value
xrandr -d :0.3 --output DVI-D-0 --brightness $value
