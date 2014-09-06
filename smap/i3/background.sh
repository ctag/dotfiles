#!/bin/bash

# Number of screens
screens=1

image=`shuf -n1 -e /home/berocs/pictures/backgrounds/*`

if ( $screens -eq '2' ); then
image2=`shuf -n1 -e /home/berocs/pictures/backgrounds/*`
fi

# Debugging
#exit

if ( $screens -eq '2' ); then
convert +append $image $image2 /tmp/bg.jpg
else
convert $image /tmp/bg.jpg
fi

#echo $image

feh --bg-center /tmp/bg.jpg
#feh --bg-center $image
