#!/usr/bin/env bash

if [ -d '$HOME/.fzf' ]; then
	e_success "Installing FZF"
	git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
	$HOME/.fzf/install --all
else
	e_arrow "FZF is already installed"
fi