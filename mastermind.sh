#!/bin/bash
#
# This is Mastermind
# A script developed to update config files
# 
# Christopher Bero [bigbero@gmail.com]
#

echo "Starting Mastermind."

args_n=$# # Store the number of input arguments to args_n
base_dir="" # Initialize base_dir variable

echo "" > mastermind.log # Initialize log file

#"${args}"

CleanLine () {
	checkline=$@ # Capture the passed variables ($@ = all pass args)
	echo "RmComments():" >> mastermind.log
	echo "Line: ${checkline}" >> mastermind.log
	firstChar=`echo "$checkline" | cut -c 1` # Cut the first character from the line to check for comments
	#echo "First Char: ${firstChar}"
	if [[ "$firstChar" = "#" ]]; then
		echo "Must be a commented line, returning '1'" >> mastermind.log
		return 1 # This line must be a comment, skip it.
	elif [[ "$firstChar" = "" ]]; then
		echo "Must be an empty line, returning '1'" >> mastermind.log
		return 1 
	else
		return 0
	fi
}

Remove () {
	rmfile=$1
	while read line
	do
		CleanLine $line # Call RmComments() to check for lines to skip
		returned=$? # Set returned information to $line
		if [[ "$returned" = "1" ]]; then
			continue # There was a comment, don't parse it
		fi
		rmline=`echo "${line}" | awk '{ print $2 }'`
		echo "rm ${rmline}" >> mastermind.log
		sudo rm -i $rmline
	done < $rmfile
}

Add () {
	nwfile=$1
	while read line
	do
		CleanLine $line # Call RmComments() to check for lines to skip
		returned=$? # Set returned information to $line
		if [[ "$returned" = "1" ]]; then
			continue # There was a comment, don't parse it
		elif [[ "$base_dir" != "" ]]; then
			echo "newlink: ${line}" >> mastermind.log
			echo "ln -s ${base_dir}${line}" >> mastermind.log
			sudo ln -v -s $base_dir$line
		else
			echo "There was a problem with $base_dir, please address. Exiting for safety." >> mastermind.log
			exit
		fi
	done < $nwfile
}

Usage () {
	echo ""
	echo "Mastermind - Usage"
	echo ""
	echo "As root:"
	echo "./mastermind newlinks.txt"
	echo "./mastermind oldlinks.txt newlinks.txt"
	echo ""
	echo "newlinks.txt format:"
	echo "format lines like the two paths in 'ln -s /path /path'"
	echo "Comment lines _must_ begin with #"
}


# Check that at least one list file is present
if [[ "$args_n" < "1" ]]
then
	echo "Mastermind requires at least one command line argument. Exiting."
	Usage # Display usage instructions
	exit
elif [[ "$args_n" > "2" ]]; then
	echo "Mastermind can only take two inputs at most. Exiting."
	Usage # Display usage instructions
	exit
fi

# If there are two arguments, then the first is an old list, the second is new.
if [[ "$args_n" = "2" ]]
then
	echo "Two arguments detected, removing original changes."
	base_dir=`head -n 1 $2` # First line of newfile is base dir
	base_dir=`echo "$base_dir" | cut -c 2-`
	Remove $1 # call remove function
	echo "Replacing with new links."
	Add $2
fi

# If there is one argument, then it is new links.
if [[ "$args_n" = "1" ]]
then
	echo "One argument detected, Adding new files."
	base_dir=`head -n 1 $1` # first line of first arg is base dir
	base_dir=`echo "$base_dir" | cut -c 2-`
	Add $1
fi









