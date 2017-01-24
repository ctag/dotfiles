#!/bin/bash

#notify-send "System will not sleep if lid is closed in the next 15 seconds."

/home/berocs/.i3/lock.sh

starttime=$(date +%s)

while [ $(( $(date +%s) - $starttime )) -lt 15 ]
do
	sleep 1
	state=$(cat /proc/acpi/button/lid/LID/state)
	array=( $state )
	if [ ${array[1]} == "closed" ]
	then
		while [ ${array[1]} == "closed" ]
		do
			sleep 5
			state=$(cat /proc/acpi/button/lid/LID/state)
			array=( $state )
		done
		sleep 1
	fi
done

notify-send "System will now sleep normally."
