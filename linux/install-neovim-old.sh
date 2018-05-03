#!/bin/bash

curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
mkdir /opt/nvim/
mv nvim.appimage /opt/nvim/nvim.appimage
chmod a+x /opt/nvim/nvim.appimage
ln -s /opt/nvim/nvim.appimage /bin/nvim
