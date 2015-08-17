#!/bin/bash

PID=$(pgrep openvpn)
VPN=$?

if [ "$VPN" -eq 0 ]; then
	deluge-gtk $@
else
	notify-send 'Deluge not started. Openvpn is down.'
fi


