#!/usr/bin/env bash

if [[ -f "/usr/bin/kr" || -f "/usr/local/bin/kr" ]]; then
    e_arrow "Krypton is already installed"
else
    e_success "Installing Krypton from https://krypt.co/kr"
    curl https://krypt.co/kr | sh
fi
