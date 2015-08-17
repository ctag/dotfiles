#!/bin/bash

if [ -r "$HOME/.dbus/Xdbus" ]; then
	. "$HOME/.dbus/Xdbus"
fi

PID=$(pgrep openvpn)
VPN=$?
echo "$VPN"
if [ "$VPN" -ne 0 ]; then
	/usr/bin/notify-send 'OpenVPN is down!'
fi
