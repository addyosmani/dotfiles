#!/bin/bash

if [ $EUID -ne 0 ]; then
	echo "☠️ You must run this as root ☠️"
	exit
fi

# Catch and log errors
trap uncaughtError ERR
function uncaughtError {
  echo -e "\n\t❌  Error\n"
  echo "$(<${ERROR_LOG})"
  echo -e "\n\t😞  Sorry\n"
  exit $?
}

function initTempDir() {
    TEMP_DIR="$(mktemp -d)"
    ERROR_LOG="${TEMP_DIR}/dotfile-install-err.log"
}

function install() {
	THEME='gauntface'
	INSTALLDIR=/usr/share/plymouth/themes
	SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
	THEME_DIR="${SCRIPT_DIR}/${THEME}/"

	echo -e "📦️  Installing Plymouth X11 tool..."
	sudo apt-get install plymouth-x11 -y	

	echo -e "✂️  Copying over theme files..."
	rm -rf ${INSTALLDIR}/${THEME}
	mkdir -p ${INSTALLDIR}/${THEME}
	cp -rf ${THEME_DIR}/* ${INSTALLDIR}/${THEME}

	echo -e "📦️  Installing theme..."
	update-alternatives --quiet --install ${INSTALLDIR}/default.plymouth default.plymouth ${INSTALLDIR}/${THEME}/${THEME}.plymouth 100
	
	echo -e "➕️  Selecting theme..."
	update-alternatives --quiet --set default.plymouth ${INSTALLDIR}/${THEME}/${THEME}.plymouth

	echo -e "🧪  Updating initramfs..."
	update-initramfs -u &> ${ERROR_LOG}
}

initTempDir
install