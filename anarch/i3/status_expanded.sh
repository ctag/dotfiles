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

	gpuTemp0=`nvidia-smi | awk 'NR == 9 { print $3 }' | grep -oE [0-9][0-9][0-9]?`

	gpuColor0=$coolTemp

	gpuExp=$(echo "$gpuTemp0 > 60.0" | bc)
	if [ "$gpuExp" -eq 1 ]
	then
		gpuColor0=$warmTemp
	fi
	gpuExp=$(echo "$gpuTemp0 > 80.0" | bc)
        if [ $gpuExp -eq 1 ]
        then
                gpuColor0=$hotTemp
        fi

cpuTemp=`sensors | awk 'NR == 27 { print $2 }' | grep -oE [0-9][0-9][0-9]?`
#echo "cpu: ${cpuTemp}"
cpuTemp2=`sensors | awk 'NR == 28 { print $2 }' | grep -oE [0-9][0-9][0-9]?`
#echo "cpu2: ${cpuTemp2}"
cpuTemp3=`sensors | awk 'NR == 26 { print $2 }' | grep -oE [0-9][0-9][0-9]?`
#echo "cpu3: ${cpuTemp3}"

cpuColor=$coolTemp

	cpuExp=$(echo "$cpuTemp > 50.0" | bc)
	if [ $cpuExp -eq 1 ]
        then
                cpuColor=$warmTemp
        fi
	cpuExp=$(echo "$cpuTemp2 > 50.0" | bc)
	if [ $cpuExp -eq 1 ]
        then
                cpuColor=$warmTemp
        fi
	cpuExp=$(echo "$cpuTemp3 > 50.0" | bc)
	if [ $cpuExp -eq 1 ]
        then
                cpuColor=$warmTemp
        fi

	cpuExp=$(echo "$cpuTemp > 60.0" | bc)
	if [ $cpuExp -eq 1 ]
        then
                cpuColor=$hotTemp
        fi
	cpuExp=$(echo "$cpuTemp2 > 60.0" | bc)
	if [ $cpuExp -eq 1 ]
        then
                cpuColor=$hotTemp
        fi
	cpuExp=$(echo "$cpuTemp3 > 60.0" | bc)
	if [ $cpuExp -eq 1 ]
        then
                cpuColor=$hotTemp
        fi

	gmailEmail=`/home/berocs/unread_bigbero.sh`
    gmailColor=$coolTemp

    if [ "$gmailEmail" -gt "0" ]; then
        gmailColor=$warmTemp
    fi
    if [ "$gmailEmail" -gt "1" ]; then
        gmailColor=$hotTemp
    fi

    gmailText="[GMAIL ${gmailEmail}]"
    gmailJSON="{ \"full_text\":\"${gmailText}\", \"color\":\"${gmailColor}\" },"

    uahEmail=`/home/berocs/unread_csb0019.sh`
    uahColor=$coolTemp

    if [ "$uahEmail" -gt "0" ]; then
        uahColor=$warmTemp
    fi
    if [ "$uahEmail" -gt "1" ]; then
        uahColor=$hotTemp
    fi


insert="[{\"full_text\":\"GPU0 [$gpuTemp0 C]\",\"color\":\"$gpuColor0\"},\
{\"full_text\":\"CPU [$cpuTemp C]\",\"color\":\"$cpuColor\"},\
{\"full_text\":\"CPU2 [$cpuTemp2 C]\",\"color\":\"$cpuColor\"},\
{\"full_text\":\"CPU3 [$cpuTemp3 C]\",\"color\":\"$cpuColor\"},\
{\"full_text\":\"GMAIL [$gmailEmail]\",\"color\":\"$gmailColor\"},\
{\"full_text\":\"UAH [$uahEmail]\",\"color\":\"$uahColor\"},"

	echo "${line/[/$insert}" || exit 1
#	echo " $gpuTemp1 $line " || exit 1
done)
