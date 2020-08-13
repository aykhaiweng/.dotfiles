#!/usr/bin/env bash

if [[ -d "$HOME/.oh-my-zsh/" ]]; then
	e_arrow "oh-my-zsh is already installed"
else
	e_success "Installing oh-my-zsh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi