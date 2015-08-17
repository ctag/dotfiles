#!/bin/bash


declare -a workspaces
index=0
newspace=9

/bin/bash /home/berocs/.i3/i3_workspaces.sh > /tmp/i3_workspaces.txt

while read line
do
	#echo "Line: ${line}"
	parse=`echo "${line}" | grep -Po '"name":.*?[^\\ ]"'`
	#echo "Parse: ${parse}"
	echo "${parse}" | grep -q 'name'
	if [ "$?" = "0" ]
	then
		#echo "${parse}"
		newItem=`echo "${parse}" | grep -Po '[0-9]{1,2}'`
		#echo "New item: ${newItem}"
		workspaces[$index]=$newItem
		if [ "$newItem" -ge "$newspace" ]
		then
			newspace=$(($newItem+1))
		fi
		#echo "workspaces ${index}: ${workspaces[$index]}"
		index=$((index+1))
	fi
done < /tmp/i3_workspaces.txt

echo "All of them: ${workspaces[*]}"

echo "i3-msg -t command workspace $newspace"

i3-msg -t command workspace $newspace

#output=`i3-msg -t get_workspaces | grep -Po '"name":.*?[^\\ ]"'`

#echo $output

#singleN=`echo "${output}" | grep -Po '[0-9]'`

#doubleN=`echo "${output}" | grep -Po '[0-9][0-9]'`

#allspaces="${singleN} ${doubleN}"

