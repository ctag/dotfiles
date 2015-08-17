#!/bin/bash

# Screen :0 - Lower Right
DISPLAY=:0 i3-msg -t command "workspace 1; exec chromium; workspace 2; exec mumble;"

# Screen :0.1 - Upper Right
DISPLAY=:0.1 i3-msg -t command "workspace 1; exec terminator; workspace 2; exec pybitmessage; workspace 3; exec bitcoin-qt; \ 
	exec litecoin-qt; exec dogecoin-qt; workspace 4; exec virtualbox;"

# Screen :0.2 - Lower Left
DISPLAY=:0.2 i3-msg -t command "workspace 1; exec terminator; workspace 5; exec terminator -l "rTorrent"; workspace 2; exec thunar;"

# Screen :0.3 - Upper Left
#cd /var/lib/boinc/
DISPLAY=:0.3 i3-msg -t command "workspace 1; exec terminator -l "SystemStatus"; workspace 2; exec (cd /var/lib/boinc/ && boincmgr);"




