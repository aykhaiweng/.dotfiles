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
e_arrow "Installing vim-plug if it doesn't already exist"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Download Vim plugins.
e_arrow "Attempting to run +PlugUpgrade and +PlugUpdate"
if [[ "$(type -P vim)" ]]; then
  vim +PlugUpgrade +PlugUpdate +qall
fi