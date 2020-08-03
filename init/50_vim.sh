# Setting up python for neovim
e_arrow "Setting up virtualenv for neovim3"
pyenv virtualenv $PYTHON3_VER neovim3
pyenv activate neovim3
pip install -U pip neovim psutil
pyenv deactivate