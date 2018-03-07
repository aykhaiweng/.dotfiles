# !/bin/bash

###############################################################################
# OSX Setup
###############################################################################

function _echo() {
	echo "[aykhaiweng says][OSX] - $1"
}

# prompt for sudo
sudo -v

# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

