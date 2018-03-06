# !/bin/bash

function _echo() {
	echo "[kurabot] - $1"
}

# declare variable for os type
uname=$(uname)

_echo "$uname detected."

if [[ $uname == 'Darwin' ]]; then
	_echo "Setting up for Darwin platform..."

	# install fonts
	_echo "Installing Nerd Font via Brew"
	brew tap caskroom/fonts
	brew cask install font-hack-nerd-font

	# install reattach-to-user-namespace
	_echo "Installing reattach-to-usernamespace via Brew"
	brew install reattach-to-user-namespace

else
	_echo "Your platform is not supported yet"
fi
