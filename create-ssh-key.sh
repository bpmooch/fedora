#!/bin/bash

EMAIL='chrismooch@gmail.com'
DEST="$HOME/.ssh/id_rsa"

while getopts ":hf:e:"a OPT
do
	case $OPT in
		h)
			echo 'Generates ssh key and copies to the clipboard'
			exit 1
			;;
		f)
			DEST=$OPTARG
			;;
		e)
			EMAIL=$OPTARG
			;;
		*)
			echo 'invalid arguments'
			;;
	esac
done

echo "$EMAIL"
echo "$DEST"

if [ -f "$DEST" ] ; then
	echo 'specified key already exists'
	exit 1
fi

# generate key
ssh-keygen -t rsa -b 4096 -C "$EMAIL" -f "$DEST" -P "" -q

# start ssh agent
RESULT=$(eval "$(ssh-agent -s)")
echo "$RESULT"

# add key to ssh-agent
ssh-add "$DEST"

KEY_PUB="$DEST.pub"
xclip -sel clip < "$KEY_PUB"
echo "The contents of $KEY_PUB have been copied to your clipboard"
