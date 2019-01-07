#!/bin/bash

if [ $EUID -ne 0 ]; then
	echo "☠️ You must run this as root ☠️"
	exit
fi

THEME='gauntface'

echo -e "📦️  Uninstalling theme..."
update-alternatives --quiet --remove default.plymouth /usr/share/plymouth/themes/${THEME}/${THEME}.plymouth

echo -e "🗑️ Deleting theme files..."
rm -rf /usr/share/plymouth/themes/${THEME}

printf "➕️ Selecting default theme..."
update-alternatives --quiet --auto default.plymouth

echo -e "🧪  Updating initramfs..."
update-initramfs -u
