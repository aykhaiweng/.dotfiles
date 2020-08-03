#!/usr/bin/env bash

# Installing TPM for tmux plugins
e_arrow "Downloading tpm for Tmux!"
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# Installing gitbar
e_arror "Downloading tmux-gitbar"
git clone https://github.com/aurelien-rainone/tmux-gitbar.git $HOME/.tmux-gitbar