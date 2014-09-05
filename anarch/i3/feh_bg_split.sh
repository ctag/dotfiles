#!/bin/bash

# http://www.imagemagick.org/Usage/crop/#crop_equal
# Take a super big image and display it across all four screens

tmpLoc="/tmp"

image0=$(shuf -n1 -e /mnt/berocs/pictures/backgrounds_3840/*)
convert $image0 -crop 2x2@ $tmpLoc/feh_bg.png

sleep 5

# Set backgrounds
DISPLAY=:0.0 feh -x -Z -F -d --bg-fill $tmpLoc/feh_bg-3.png &
DISPLAY=:0.1 feh -x -Z -F -d --bg-fill $tmpLoc/feh_bg-1.png &
DISPLAY=:0.2 feh -x -Z -F -d --bg-fill $tmpLoc/feh_bg-2.png &
DISPLAY=:0.3 feh -x -Z -F -d --bg-fill $tmpLoc/feh_bg-0.png &
