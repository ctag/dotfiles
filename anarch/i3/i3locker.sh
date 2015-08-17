#!/bin/bash

sleep 1

# Start xscreensaver
xscreensaver-command --lock

sleep 5

exit

/home/berocs/.i3/screen.sh standby

#`sleep 30

#qmotion

exit

# i3lock only accepts .png files
tmpLoc="/tmp"
image0=$(shuf -n1 -e /mnt/berocs/pictures/backgrounds_3840/*)
convert $image0 -crop 2x2@ $tmpLoc/screen_lock.png

# blank the other screens to prevent minor snooping
DISPLAY=:0.1 i3-msg workspace "lock"
DISPLAY=:0.1 feh -x -Z -F $tmpLoc/screen_lock-1.png &
pid1=$!

DISPLAY=:0.2 i3-msg workspace "lock"
DISPLAY=:0.2 feh -x -Z -F $tmpLoc/screen_lock-2.png &
pid2=$!

DISPLAY=:0.3 i3-msg workspace "lock"
DISPLAY=:0.3 feh -x -Z -F $tmpLoc/screen_lock-0.png &
pid3=$!

# lock the main screen
DISPLAY=:0.0 i3-msg workspace "lock"
i3lock -i $tmpLoc/screen_lock-3.png -n &
lockpid=$!
#echo "i3lock: $lockpid"

# wait until the lock is opened
wait $lockpid

# automatically pull down the blinders on ancillary screens
kill $pid1 $pid2 $pid3

# Revert workspaces
DISPLAY=:0.0 i3-msg workspace 1
DISPLAY=:0.1 i3-msg workspace 1
DISPLAY=:0.2 i3-msg workspace 1
DISPLAY=:0.3 i3-msg workspace 1

