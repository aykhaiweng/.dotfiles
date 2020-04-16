#!/bin/bash

###############################################################################
# OSX Setup
###############################################################################


_echo() {
	echo "[aykhaiweng says] [OSX] - $1"
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
	brew bundle --file="$SETUP_DIR/brew/Brewfile"

	# Applying prefered settings
	_echo "Applying prefered MacOSX settings"
	source $SETUP_DIR/osx/mac-osx-settings.sh
}

# invoke main
main
