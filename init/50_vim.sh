#!/usr/bin/env bash

# Setting up python for neovim
e_arrow "Setting up virtualenv for neovim3"
pyenv virtualenv $PYTHON3_VER neovim3
pyenv activate neovim3
pip install -U pip neovim psutil
pyenv deactivate

# Backups, swaps and undos are stored here.
mkdir -p $DOTFILES/caches/vim

# Installing vim-plug
vim_plug_install_dir=$HOME/.vim/autoload/plug.vim
if [[ ! -f $vim_plug_install_dir ]]; then
	e_arrow "Installing vim-plug"
	curl -fLo $vim_plug_install_dir --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Download Vim plugins.
if [[ "$(type -p vim)" ]]; then
	e_arrow "Running vim +PlugUpgrade and +PlugUpdate"
    vim +PlugUpgrade +PlugUpdate +qall
fi