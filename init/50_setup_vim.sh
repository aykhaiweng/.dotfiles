#!/usr/bin/env bash

# Dependencies
source $DOTFILES/source/30_pyenv.sh

# Setting up python for neovim
if [[ $(pyenv versions | grep neovim3) ]]; then
    e_arrow "Virtualenv for neovim3 already exists"
else
    e_success "Creating virtualenv for neovim3"
    pyenv virtualenv $PYTHON3_VER neovim3
fi

e_arrow "Setting up virtualenv for Neovim"
e_arrow "Activating neovim3 virtualenv"
pyenv activate neovim3
e_arrow "Installing pip in neovim3 virtualenv"
pip install -U pip neovim psutil pynvim
e_arrow "Exiting neovim3 virtualenv"
pyenv deactivate

# Backups, swaps and undos are stored here.
mkdir -p $DOTFILES/caches/vim

# Installing vim-plug
vim_plug_install_dir=$HOME/.vim/autoload/plug.vim
if [[ ! -f $vim_plug_install_dir ]]; then
    e_arrow "Installing vim-plug"
    curl -fLo $vim_plug_install_dir --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Download nvim plugins.
# if [[ "$(type -p nvim)" ]]; then
#     e_arrow "Running nvim +PlugUpgrade +PlugUpdate +UpdateRemotePlugins"
#     nvim +'PlugUpgrade' +'PlugUpdate --sync' +qall
# fi
