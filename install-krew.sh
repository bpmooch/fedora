#!/bin/bash

set -e

. ./lib/install.sh
. ./lib/util.sh

info 'Krew' 'Installing krew'
install_krew

info 'Krew' 'PATH Update'
request 'Add Krew to PATH? [Y/n]'
read EDIT_PATH
if [ "$EDIT_PATH" = "n" ];
then
	info 'Krew' 'PATH not modified. Exiting...'
	exit 0
else
	if [ -e "$HOME/.profile" ];
	then
		echo "export VOLTA_HOME=\"$HOME/.volta\"" >> ~/.profile
		echo "export PATH=\"$VOLTA_HOME/bin:$PATH\"" >> ~/.profile
	else
		echo "export VOLTA_HOME=\"$HOME/.volta\"" >> ~/.bashrc
		echo "export PATH=\"$VOLTA_HOME/bin:$PATH\"" >> ~/.bashrc
	fi
	. ~/.bashrc
fi

info 'Krew' 'Install useful tools'
request 'Install useful krew plugins? [Y/n]'
read INSTALL_PLUGINS
if [ "$INSTALL_PLUGINS" = "n" ];
then
	info 'Krew' 'Exiting...'
	exit 0
else
	install_krew_plugins
fi
