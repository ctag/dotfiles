#!/bin/bash

#
# Christopher Bero - 2015
#

TRACKPAD='SynPS/2 Synaptics TouchPad'
TRACKPOINT='TPPS/2 IBM TrackPoint'

TRACKPAD_E=$(xinput --list-props "${TRACKPAD}" | grep 'Enabled' | awk '{i=NF; print $i;}')
TRACKPOINT_E=$(xinput --list-props "${TRACKPOINT}" | grep 'Enabled' | awk '{i=NF; print $i;}')

if [ ${TRACKPAD_E} -eq 1 ] && [ ${TRACKPOINT_E} -eq 1 ]  
then
	xinput --disable "${TRACKPAD}"
	notify-send 'Trackpad: Disabled' 'Trackpoint: Enabled'
elif [ ${TRACKPAD_E} -eq 0 ] && [ ${TRACKPOINT_E} -eq 1 ]  
then
	xinput --enable "${TRACKPAD}"
	xinput --disable "${TRACKPOINT}"
	notify-send 'Trackpad: Enabled' 'Trackpoint: Disabled'
elif [ ${TRACKPAD_E} -eq 1 ] && [ ${TRACKPOINT_E} -eq 0 ]  
then
	xinput --enable "${TRACKPOINT}"
	xinput --enable "${TRACKPAD}"
	notify-send 'Trackpad: Enabled' 'Trackpoint: Enabled'
elif [ ${TRACKPAD_E} -eq 0 ] && [ ${TRACKPOINT_E} -eq 0 ]  
then
	xinput --enable "${TRACKPOINT}"
	xinput --enable "${TRACKPAD}"
	notify-send 'Trackpad: Enabled' 'Trackpoint: Enabled'
fi



