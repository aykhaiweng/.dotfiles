#!/usr/bin/env bash

# Installing TPM for tmux plugins
if [[ ! -d $HOME/.tmux/plugins/tpm ]]; then
	e_arrow "Downloading tpm for Tmux!"
	git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
fi

# Installing gitbar
if [[ ! -d $HOME/.tmux-gitbar ]]; then
	e_arrow "Downloading tmux-gitbar"
	git clone https://github.com/aurelien-rainone/tmux-gitbar.git $HOME/.tmux-gitbar
fi