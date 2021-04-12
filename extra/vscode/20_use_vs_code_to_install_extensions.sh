#!/usr/bin/env sh

while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "Installing $line using VSCode"
    code --user-data-dir $VSCODE_EXTENSIONS_DIRECTORY --install-extension $line
done < "$1"
