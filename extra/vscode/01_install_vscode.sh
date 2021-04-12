#!/usr/bin/env bash

# This currently only works on Ubuntu
VSCODE_VERSION="1.54.2"

wget "https://update.code.visualstudio.com/$VSCODE_VERSION/linux-deb-x64/stable" -O "/tmp/vscode-$VSCODE_VERSION-linux-x64.deb"
sudo apt install "/tmp/vscode-$VSCODE_VERSION-linux-x64.deb"
