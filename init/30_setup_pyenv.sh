#!/usr/bin/env bash

# Dependencies
source $DOTFILES/source/30_pyenv.sh

# Enable configuration options for Python
is_osx && export PYTHON_CONFIGURE_OPTS="--enable-framework"
is_ubuntu && export PYTHON_CONFIGURE_OPTS="--enable-shared"

PYTHON3_VER="3.9.0"

# Now that all that is done, install python into pyenv
# installing pyenv 3.6.4 and 2.7.13
if [[ $(pyenv versions | grep $PYTHON3_VER) ]]; then
    e_arrow "Python $PYTHON3_VER is already installed"
else
    e_success "Installing Python $PYTHON3_VER with pyenv..."
    yes '' | pyenv install $PYTHON3_VER
    pyenv global $PYTHON3_VER
    pip install -U pip
fi
