#!/usr/bin/env bash

# Dependencies
source $DOTFILES/source/10_pyenv.sh

# Enable configuration options for Python
is_osx && export PYTHON_CONFIGURE_OPTS="--enable-framework" 
is_ubuntu && export PYTHON_CONFIGURE_OPTS="--enable-shared" 

PYTHON3_VER="3.8.5"

# Now that all that is done, install python into pyenv
# installing pyenv 3.6.4 and 2.7.13
e_arrow "Installing $PYTHON3_VER with pyenv..."
yes '' | pyenv install $PYTHON3_VER