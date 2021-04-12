#!/usr/bin/env bash

# Global Args
export VSCODE_SYNC_GISTID="df8dc3af6d28c0362da4e5ef02b46459/raw"
export VSCODE_SYNC_GISTURL="https://gist.githubusercontent.com/aykhaiweng/$VSCODE_SYNC_GISTID"
export VSCODE_EXTENSIONSJSON="$VSCODE_SYNC_GISTURL/extensions.json"
export VSCODE_SETTINGSJSON="$VSCODE_SYNC_GISTURL/settings.json"
export VSCODE_STAGING_DIRECTORY="/tmp/code"
export VSCODE_EXTENSIONS_DIRECTORY="~/.config/Code"

# VSCode stuff
echo "> Pulling the extensions.json and settings.json from $VSCODE_SYNC_GISTURL"
source $DOTFILES/extra/vscode/10_pull_vscode_extensions_from_gist.sh
echo "> Attempting to install extensions from $VSCODE_STAGING_DIRECTORY/extensions.list"
source $DOTFILES/extra/vscode/20_use_vs_code_to_install_extensions.sh /tmp/code/extensions.list

# Code-server stuff
echo "> Making the missing .code-server dir"
mkdir -p $HOME/.code-server/User
echo "> Importing the settings and extensions to code-server"
source $DOTFILES/extra/code-server/20_import_extensions_from_vscode.sh
