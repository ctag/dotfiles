#!/bin/bash

# Statusbar expanded
# Christopher Bero [bigbero@gmail.com]
# 2014

#
# Network Transfer Stats
#

#ethDown=`bwm-ng -o plain -c 1 -t 1000 -u bits | awk '$1 == "total:" { print $2 $3 }'`
#ethUp=`bwm-ng -o plain -c 1 -t 1000 -u bits | awk '$1 == "total:" { print $4 $5 }'`

#
# GPU0, CPU, and CASE Temperatures
#
coolTemp="#009999" # 008888
warmTemp="#BBBB00" # 997777
hotTemp="#FF0000" # FF0000

i3status | (read line && echo $line && read line && echo $line && while :
do
	read line

	gpuTemp0=`sensors | awk '$1 == "temp1:" && NR < 6 { print $2 }' | grep -oE [0-9][0-9][0-9]?`

	gpuColor0=$coolTemp

	gpuExp=$(echo "$gpuTemp0 > 60.0" | bc)
	if [ "$gpuExp" -eq 1 ]
	then
		gpuColor0=$warmTemp
	fi
	gpuExp=$(echo "$gpuTemp0 > 73.0" | bc)
        if [ $gpuExp -eq 1 ]
        then
                gpuColor0=$hotTemp
        fi

cpuTemp=`sensors | awk '$1 == "temp2:" && NR > 30 { print $2 }' | grep -oE [0-9][0-9][0-9]?`
#echo "cpu: ${cpuTemp}"
caseTemp=`sensors | awk '$1 == "temp3:" && NR > 30 { print $2 }' | grep -oE [0-9][0-9][0-9]?`
#echo "case: ${caseTemp}"

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

bigbero=`/home/berocs/.i3/bigbero_check.sh`
csb=`/home/berocs/.i3/csb0019_check.sh`


insert="[{\"full_text\":\"GPU0 [$gpuTemp0 C]\",\"color\":\"$gpuColor0\"},\
{\"full_text\":\"CPU [$cpuTemp C]\",\"color\":\"$cpuColor\"},\
{\"full_text\":\"CASE [$caseTemp C]\",\"color\":\"$caseColor\"},\
{\"full_text\":\"GMAIL [$bigbero]\",\"color\":\"$warmTemp\"},\
{\"full_text\":\"UAH [$csb]\",\"color\":\"$warmTemp\"},"

	echo "${line/[/$insert}" || exit 1
#	echo " $gpuTemp1 $line " || exit 1
done)
