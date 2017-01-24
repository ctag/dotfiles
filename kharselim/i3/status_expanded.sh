#!/bin/bash

#
# General colors for salient output
#
coolTemp="#009999" # 008888
warmTemp="#BBBB00" # 997777
hotTemp="#FF0000" # FF0000

i3status | (read line && echo $line && read line && echo $line && while :
do
	read line

### System Uptime
	#uptime=`uptime | grep -o -e 'up\ *[0-9:]*' | grep -o -e '[0-9:]*'`
	uptime=`cat /proc/uptime | grep -o -e '^[0-9]*'`
	uptimeText="[up ${uptime}s]"
	uptimeJSON="[{ \"full_text\":\"${uptimeText}\",\"color\":\"#009999\" },"
	
### Number of available package updates
	updates=`cat /home/berocs/.i3/pkg_updates.txt`
	updatesText="[${updates} pkgs]"
    updatesColor=$coolTemp
	updatesExp=$(echo "$updates > 50" | bc)
	if [ $updatesExp -eq 1 ]
    then
        updatesColor=$warmTemp
    fi
	updatesExp=$(echo "$updates > 100" | bc)
	if [ $updatesExp -eq 1 ]
    then
        updatesColor=$hotTemp
    fi
	updatesJSON="{ \"full_text\":\"${updatesText}\",\"color\":\"${updatesColor}\" },"

### Fan speed
	#fan=`sensors | awk '$1 == "fan1:" { print $2 }'` # X200
	fan=`sensors | grep -o '^Processor Fan:.*' | grep -o '[0-9]* RPM' | grep -o '[0-9]*'` # Dell Precision
	fan=`echo "${fan}/10" | bc`
	fanColor=$coolTemp
    fanExp=$(echo "$fan > 400" | bc)
	if [ $fanExp -eq 1 ]
    then
        fanColor=$hotTemp
    fi
    fanText="[${fan} RPM]"
	fanJSON="{ \"full_text\":\"${fanText}\",\"color\":\"$fanColor\" },"
  
### CPU Temperature 
    #cpuTemp=`sensors | awk '$1 == "temp1:" && NR > 4 && NR < 10 { print $2 } ' | grep -o [0-9][0-9]\.[0-9]` # X200
	cpuTemp=`sensors | grep -o '^CPU:.*' | grep -o '[0-9]*\.[0-9]*'` # Dell Precision
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

### Output final json line
    echo "${line/[/${uptimeJSON}${updatesJSON}${fanJSON}${cpuJSON}}" || exit 1
done)

