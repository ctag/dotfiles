#!/bin/bash

username="bigbero@gmail.com"
password="NetFragAcidBurn"
atomlines=`curl -su $username:$password "https://mail.google.com/mail/u/0/feed/atom" | sed -e 's/>/>\n/g' | grep "</fullcount>" | cut -d '<' -f 1`

echo "$atomlines"
exit

if [ $atomlines -gt "0" ]; then
	echo "new mail"
else
	echo "no mail"
fi
