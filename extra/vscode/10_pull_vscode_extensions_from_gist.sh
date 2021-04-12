#!/usr/bin/env bash

# Make the missing dir
mkdir -p $VSCODE_STAGING_DIRECTORY

# Download the extensions files from the gist
curl $VSCODE_EXTENSIONSJSON --output $VSCODE_STAGING_DIRECTORY/extensions.json
curl $VSCODE_SETTINGSJSON --output $VSCODE_STAGING_DIRECTORY/settings.json

# Parse the extensions list
jq -r ".[].metadata.publisherId" $VSCODE_STAGING_DIRECTORY/extensions.json > $VSCODE_STAGING_DIRECTORY/extensions.list
