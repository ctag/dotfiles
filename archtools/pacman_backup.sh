#!/bin/bash

#
# Backs up the list of installed pacman packages
# Christopher Bero - Dec 2014
#

echo "Checking that backup folder exists."

backupDir=`date +"%Y_%m_%d"`
backupPath="/mnt/bkup/bns-anarch/$backupDir/"

if [[ ! -d "$backupPath" ]]
then
	echo "Backup folder doesn't exist, creating it now."
	echo "mkdir $backupPath"
	mkdir "$backupPath"
else
	echo "backup folder exists, proceeding with overwrite."
fi

echo "Backing up package list to /mnt/bkup/pkg.list"

# To restore packages:
# sudo pacman -S --needed $(< /mnt/bkup/pkg.list )

sudo pacman -Qqne > ${backupPath}/pacman_pkg_list.txt

echo "Progressing to backup pacman database"

# To restore pacman database:
# move pacman-database.tar.bz2 to /
# tar -xzvf pacman-database.tar.bz2

tar -cjf ${backupPath}/pacman_database.tar.bz2 /var/lib/pacman/local/*

