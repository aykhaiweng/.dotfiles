#!/bin/bash
trap "exit" INT


# Get the color definitions
source colordefinitions.sh
# declare current directory
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

_echo() {
	echo "[${LIGHTCYAN}aykhaiweng${NOCOLOR} says] - $1"
}


main() {
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
	
	# ZSH STUFF
	# set zsh as default
	# if [[ $SHELL != '/bin/zsh' ]]; then
	# 	_echo "Current SHELL changing to `/bin/zsh`"
	# 	chsh -s $(which zsh)
	# fi
	# now we install .oh-my-zsh
	_echo "Installing .oh-my-zsh"
	git clone git://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
	_echo "Installing zsh-competions"
	git clone https://github.com/zsh-users/zsh-completions $HOME/.oh-my-zsh/custom/plugins/zsh-completions
	_echo "Installing zsh-autosuggestions"
	git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/plugins/zsh-autosuggestions

	
	# VIM STUFF
	# installing Vundle
	_echo "Cloning Vundle..."
	git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim


	# PYTHON STUFF
	# updating pip and it's prerequisites
	_echo "Upgrading pip and installing prerequisites."
	sudo pip3 install --upgrade pip
	sudo pip3 install flake8 virtualenv gunicorn ipython
	# prepare to symlink the files
	_echo "Now preparing to symlink files."
	python3 $THIS_DIR/symlink.py
	# run the aliases file to get the pyenv out
	_echo "Running the $HOME/.aliases file that we symlinked earlier"
	source $HOME/.aliases
	# Now that all that is done, install python into pyenv
	# installing pyenv 3.6.4 and 2.7.13
	export PYTHON_CONFIGURE_OPTS="--enable-framework"
	_echo "Installing python 3.6.4 with pyenv..."
	yes '' | pyenv install 3.6.4
	_echo "Installing python 2.7.13 with  pyenv..."
	yes '' | pyenv install 2.7.13
	_echo "Setting python 3.6.4 as the global default"
	pyenv global 3.6.4


	# FZF STUFF
	_echo "Installing FZF"
	git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
	$HOME/.fzf/install --all


	# TMUX STUFF
	_echo "Downloading tpm for Tmux!"
	git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
	_echo "Downloading tmux-git"
	git clone https://github.com/drmad/tmux-git.git $HOME/.tmux/tmux-git
	_echo "Downloading tmux-gitbar"
	git clone https://github.com/aurelien-rainone/tmux-gitbar.git $HOME/.tmux/tmux-gitbar


	# install vim plugins
	_echo "Installing VIM Plugins..."
	vim -c 'PluginInstall' -c 'qa!'
	# install ycm from vim plugins
	_echo "Compiling YCM..."
	python $HOME/.vim/bundle/YouCompleteMe/install.py
	

	# SSH STUFF
	# create an id_rsa file if it doesn't already exist
	if [ ! -f $HOME/.ssh/id_rsa ]; then
		ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -N ''
		_echo "A ssh-key with the default name ($HOME/.ssh/id_rsa) has been created for you!"
		_echo "Here is the key:"
		echo "$(cat $HOME/.ssh/id_rsa.pub)"
	fi


	# finalize
	_echo "Reloading $HOME/.zshrc."
	exec "$SHELL"
	source $HOME/.zshrc
	_echo ".dotfiles setup complete! Enjoy."
}

# invoke main
main
