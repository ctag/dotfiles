#!/bin/bash

image0=$(shuf -n1 -e /home/berocs/Pictures/backgrounds/*)
feh -x -Z -F -d --bg-fill $image0 &

exit

image3=$(shuf -n1 -e /mnt/berocs/pictures/backgrounds/*)
DISPLAY=:0.3 feh -x -Z -F -d --bg-fill $image3 &

