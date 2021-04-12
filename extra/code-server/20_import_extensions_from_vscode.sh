#!/usr/bin/env bash

# Import the extensions from VSCode
cp "$VSCODE_STAGING_DIRECTORY/settings.json" $HOME/.code-server/User/settings.json
cp -r $HOME/.vscode/extensions $HOME/.code-server/extensions
