#!/bin/bash

mkdir /opt/nvim
curl -LO -o /opt/nvim/nvim.appimage https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod a+x /opt/nvim/nvim.appimage
ln -s /opt/nvim/nvim.appimage /bin/nvim
