#!/bin/bash

if [ $EUID -ne 0 ]; then
	echo "☠️ You must run this as root ☠️"
	exit
fi

plymouthd --debug --debug-file=/home/matt/Projects/Tools/dotfiles/plymouth.debug
plymouth --show-splash
for ((I=0;I<10;I++))
do
  	sleep 1s
	# plymouth --update=event$I
done
plymouth quit