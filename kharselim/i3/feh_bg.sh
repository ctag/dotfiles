#!/bin/bash

# Regular random background
image0=$(shuf -n1 -e /home/berocs/pictures/backgrounds/*)
feh -x -Z -F -d --bg-fill $image0 &

# Show the colemak image
#image0=/home/berocs/pictures/colemak_layout.gif
#feh -x -F --bg-center $image0 &

# Dunno
#image3=$(shuf -n1 -e /mnt/berocs/pictures/backgrounds/*)
#DISPLAY=:0.3 feh -x -Z -F -d --bg-fill $image3 &

