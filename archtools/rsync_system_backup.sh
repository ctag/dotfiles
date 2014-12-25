#!/bin/bash

#
# Full system backup with rsync
# Christopher Bero - Jan 2014
# Last updated December 2014
#

echo "Backing up the entire system."

backupDir=`date +"%Y_%m_%d"`
backupPath="/mnt/bkup/bns-anarch/$backupDir/"

if [[ ! -d "$backupPath" ]]
then
	echo "Backup folder doesn't exist, creating it now."
	echo "mkdir $backupPath"
	mkdir "$backupPath"
else
	echo "backup folder exists, continue-ing with overwrite."
fi

sudo rsync -aAv /* rsync://192.168.13.14/bkup/bns-anarch/latestBackup/ --delete \
--exclude={/dev/*,/proc/*,/sys/*,/tmp/*,/run/*,/mnt/*,/media/*,/lost+found,/var/lib/pacman/sync/*,/var/log/journal/*,/var/lib/boinc/slots/*,/home/berocs/} \
> /home/berocs/Documents/archtools/rsync.output

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
cp -ar /mnt/bkup/bns-anarch/latestBackup/* ${backupPath}

echo "Done!"


