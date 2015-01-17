#!/bin/bash

# Statusbar expanded
# Christopher Bero [bigbero@gmail.com]
# 2014

#
# Network Transfer Stats
#

#lowColor="#00FFFF"
#highColor="FF0000"

#ethDown=`bwm-ng -o plain -c 1 -t 1000 -u bits | awk '$1 == "total:" { print $2 $3 }'`
#ethUp=`bwm-ng -o plain -c 1 -t 1000 -u bits | awk '$1 == "total:" { print $4 $5 }'`

#
# GPU0, GPU1, CPU, and CASE Temperatures
#
coolTemp="#009999" # 008888
warmTemp="#BBBB00" # 997777
hotTemp="#FF0000" # FF0000

i3status | (read line && echo $line && read line && echo $line && while :
do
	read line

	gpuTemp0=-1 #`nvidia-smi -q -d TEMPERATURE | awk '$6 == "C" { if (NR<11) print $5 }'`
	gpuTemp1=-1 #`nvidia-smi -q -d TEMPERATURE | awk '$6 == "C" { if (NR>11) print $5 }'`
	
	gpuColor0=$coolTemp
	gpuColor1=$coolTemp
	
	if [ "$gpuTemp0" -gt "70" ]
	then
		gpuColor0=$warmTemp
	fi
        if [ $gpuTemp1 -gt 70 ]
        then
                gpuColor1=$warmTemp
        fi

        if [ $gpuTemp0 -gt 85 ]
        then
                gpuColor0=$hotTemp
        fi
        if [ $gpuTemp0 -gt 85 ]
        then
                gpuColor0=$hotTemp
        fi
	
cpuTemp=`sensors | awk '$1 == "temp1:" { if (NR<12) print $2 }' | grep -o [0-9][0-9]\.[0-9]`
caseTemp=`sensors | awk '$1 == "temp2:" { if (NR>10) print $2 }' | grep -o [0-9][0-9]\.[0-9]`

cpuColor=$coolTemp
caseColor=$coolTemp
	
	cpuExp=$(echo "$cpuTemp > 50.0" | bc)
	if [ $cpuExp -eq 1 ]
        then
                cpuColor=$warmTemp
        fi
	cpuExp=$(echo "$cpuTemp > 60.0" | bc)
	if [ $cpuExp -eq 1 ]
        then
                cpuColor=$warmTemp
        fi
	caseExp=$(echo "$caseTemp > 55" | bc)
	if [ $caseExp -eq 1 ]
        then
                caseColor=$hotTemp
        fi
	caseExp=$(echo "$caseTemp > 60" | bc)
        if [ $caseExp -eq 1 ]
        then
                caseColor=$hotTemp
        fi



#	insert="[{\"full_text\":\"GPU0 [0 C]\",\"color\":\"$gpuColor0\"},\
		{\"full_text\":\"CPU [$cpuTemp C]\",\"color\":\"$cpuColor\"},\
		{\"full_text\":\"CASE [$caseTemp C]\",\"color\":\"$caseColor\"},"

	echo "${line/[/$insert}" || exit 1
#	echo " $gpuTemp1 $line " || exit 1
done)
