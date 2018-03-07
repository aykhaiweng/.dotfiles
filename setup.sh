# !/bin/bash

function _echo() {
	echo "[kurabot] - $1"
}

# prompt for sudo
_echo "Before I start installing anything, I'm going to need your password for sudo access."
sudo -v

# declare variable for os type
uname=$(uname)

_echo "$uname detected."

if [[ $uname == 'Darwin' ]]; then
	_echo "Setting up for Darwin platform."
	source osx/setup-osx.sh
elif [[ $uname == 'Linux' ]]; then
	_echo "Setting up for Linux platform."
	source linux/setup-linux.sh
else
	_echo "Your platform is not supported yet."
fi

# install the brew bundle
brew bundle --file=brew/Brewfile

# prepare to symlink the files
_echo "Now preparing to symlink files."
python symlink.py

_echo "Reloading ~/.zshrc."
source ~/.zshrc
_echo ".dotfiles setup complete! Enjoy living in a world of monogamy."
