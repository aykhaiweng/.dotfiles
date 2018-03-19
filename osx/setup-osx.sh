#!/bin/bash

###############################################################################
# OSX Setup
###############################################################################


# Get the color definitions
source $THIS_DIR/colordefinitions.sh

_echo() {
	echo "[${LIGHTCYAN}aykhaiweng${NOCOLOR} says] [${CYAN}OSX${NOCOLOR}] - $1"
}


# prompt for sudo
sudo -v


main() {
	# Install brew
	if ! which brew >/dev/null; then
		_echo "Installing Brew."
		yes '' | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	else
		_echo "Brew already installed, skipping installation"
	fi
	# install the brew bundle
	_echo "Installing Brewfile"
	brew bundle --file=brew/Brewfile

	# add the oceanic item colors
	_echo "Activating iterm2 colors based on OceanicNext"
	open $THIS_DIR/iterm2/OceanicNext.itermcolors
}

# invoke main
main
