#!/bin/bash

#
# Full system backup with rsync
# Christopher Bero - Jan 2014
# Last updated December 2014
#

backupNFS="/mnt/bkup"

echo "Backing up the entire system."

echo "Pulling computer name from first argument."
backupComp=$1

echo "Computer name: $backupComp"

if [[ "$backupComp" = "" ]]
then
	echo "This script requires a computer name (bns-anarch, bns-kharselim) as the first argument."
	echo "Exiting."
	exit
fi

backupDir=`date +"%Y_%m_%d"`
backupPath="$backupNFS/$backupComp/$backupDir/"

if [[ ! -d "$backupPath" ]]
then
	echo "Backup folder doesn't exist, creating it now."
	echo "mkdir $backupPath"
	mkdir "$backupPath"
else
	echo "backup folder exists, continue-ing with overwrite."
fi

sudo rsync -aAv /* rsync://192.168.13.14/bkup/$backupComp/latestBackup/ --delete \
--exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found,/var/lib/pacman/sync/*,/var/log/journal/*,/var/lib/boinc/slots/*,/home/berocs/} \
> /home/berocs/Documents/dotfiles/archtools/output.rsync

rsyncStatus=$?

if [[ "$rsyncStatus" = "0" ]]
then
	echo "rsync status 0, backup appears to be a success."
else
	echo "rsync returned non, normal status: $rsyncStatus."
	echo "Check backup, something may be wrong."
	exit
fi

echo "Moving contents to permenant folder."
sudo cp -ar $backupNFS/$backupComp/latestBackup/* ${backupPath}

echo "Done!"


