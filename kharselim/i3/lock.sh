#!/bin/bash

revert()
{
	xset dpms 0 0 0
	xset dpms force on
}

#trap revert SIGHUP SIGINT SIGTERM

#xset +dpms dpms 0 0 1
#sleep 5
#xset dpms force on
/home/berocs/.i3/screen.sh standby
#systemd-inhibit --what=handle-lid-switch i3lock -n -u -e -c 1111FF -i /home/berocs/pictures/i3lock/bsod.png
systemd-inhibit --what=handle-lid-switch xscreensaver-command -lock
#revert
