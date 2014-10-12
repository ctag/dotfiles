#!/bin/bash

# Set one image per screen

image0=$(shuf -n1 -e /mnt/berocs/pictures/backgrounds_3840/*)
feh -x -Z -F -d --bg-fill --no-xinerama $image0 &

exit

# Set backgrounds
image0=$(shuf -n1 -e /mnt/berocs/pictures/backgrounds/*)
DISPLAY=:0.0 feh -x -Z -F -d --bg-fill $image0 &
image1=$(shuf -n1 -e /mnt/berocs/pictures/backgrounds/*)
DISPLAY=:0.1 feh -x -Z -F -d --bg-fill $image1 &
image2=$(shuf -n1 -e /mnt/berocs/pictures/backgrounds/*)
DISPLAY=:0.2 feh -x -Z -F -d --bg-fill $image2 &
image3=$(shuf -n1 -e /mnt/berocs/pictures/backgrounds/*)
DISPLAY=:0.3 feh -x -Z -F -d --bg-fill $image3 &

