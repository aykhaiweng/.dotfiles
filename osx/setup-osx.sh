# !/bin/bash

###############################################################################
# OSX Setup
###############################################################################

function _echo() {
	echo "[aykhaiweng says][OSX] - $1"
}

# prompt for sudo
sudo -v


main() {
	# Install brew
	_echo "Installing Brew."
	yes '' | /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

	# install the brew bundle
	brew bundle --file=brew/Brewfile

	# add the oceanic item colors
	source $HOME/.dotfiles/iterm2/OceanicNext.itermcolors
}

# invoke main
main
