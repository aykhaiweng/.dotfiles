#!/usr/bin/env bash

# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

# Create a bin folder for local users
if [[ -f "/usr/bin/batcat" && ! -f "$HOME/.local/bin/bat" ]]; then
    e_arrow "Creating link for batcat"
    mkdir -p $HOME/.local/bin
    ln -s /usr/bin/batcat $HOME/.local/bin/bat
fi
