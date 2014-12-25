#!/bin/bash

#
# Reflector Script
# Christopher Bero - Jan 2014
#

echo "This script will overwrite /etc/pacman.d/mirrorlist. Use with caution!"
echo "This script uses sudo, be wary."

sudo reflector --verbose --latest 40 --number 10 --sort rate --protocol http --save /etc/pacman.d/mirrorlist
