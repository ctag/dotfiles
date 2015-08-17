#!/bin/bash

xscreensaver-command -watch | ( while true
do read X
	if echo $X | grep "LOCK" &> /dev/null; then
		#echo "locking at $(date)" >> $HOME/time_xprofile
		echo "locking at $(date)"
		xinput set-prop 8 150 0 # Disables mouse
	elif echo $X | grep "UNBLANK" &> /dev/null; then
       	#echo "unlocking at $(date)" >> $HOME/time_xprofile
       	echo "unlocking at $(date)"
		xinput set-prop 8 150 1 # enables mouse (id 8, property 150)
		fi
done )
