#!/bin/bash

# Statusbar expanded
# Christopher Bero [bigbero@gmail.com]
# 2015

#
# GPU0, GPU1, CPU, and CASE Temperatures
#
coolTemp="#009999" # 008888
warmTemp="#BBBB00" # 997777
hotTemp="#FF0000" # FF0000

i3status | (read line && echo $line && read line && echo $line && while :
do
	read line
	fan=`sensors | awk '$1 == "fan1:" { print $2 }'`
	fan=`echo "${fan}/10" | bc`

	fanColor=$coolTemp
	fanExp=$(echo "$fan > 400" | bc)
	if [ $fanExp -eq 1 ]
        then
                fanColor=$hotTemp
        fi
    fanExp=$(echo "$fan < 100" | bc)
	if [ $fanExp -eq 1 ]
        then
                fanColor=$hotTemp
        fi
    
    fanText="[${fan} RPM]"
	fanJSON="[{ \"full_text\":\"${fanText}\",\"color\":\"$fanColor\" },"
	#"[{\"full_text\":\"GPU0 [0 C]\",\"color\":\"$gpuColor0\"},
    
    cpuTemp=`sensors | awk '$1 == "temp1:" && NR > 4 && NR < 10 { print $2 } ' | grep -o [0-9][0-9]\.[0-9]`
    
    cpuColor=$coolTemp
    
	cpuExp=$(echo "$cpuTemp > 65" | bc)
	if [ $cpuExp -eq 1 ]
        then
                cpuColor=$warmTemp
        fi
	cpuExp=$(echo "$cpuTemp > 75" | bc)
	if [ $cpuExp -eq 1 ]
        then
                cpuColor=$hotTemp
        fi

    cpuText="[${cpuTemp} C]"
    cpuJSON="{ \"full_text\":\"${cpuText}\", \"color\":\"${cpuColor}\" },"

    bigberoEmail=`/home/berocs/unread_bigbero.sh`
    bigberoText="[GMAIL ${bigberoEmail}]"
    bigberoJSON="{ \"full_text\":\"${bigberoText}\", \"color\":\"${warmTemp}\" },"

    uahEmail=`/home/berocs/unread_csb0019.sh`
    uahText="[UAH ${uahEmail}]"
    uahJSON="{ \"full_text\":\"${uahText}\", \"color\":\"${warmTemp}\" },"
	
    echo "${line/[/${fanJSON}${cpuJSON}${bigberoJSON}${uahJSON}}" || exit 1
done)

