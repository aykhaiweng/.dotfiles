#!/usr/bin/env bash

# OSX-only stuff. Abort if not OSX.
is_osx || return 1
[[ $SKIP_BREW -eq "1" ]] && e_arrow "Skipping Brew setup" && return 1

# Install Homebrew.
if [[ ! $(command -v brew) ]]; then
    e_success "Installing Homebrew"
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Exit if, for some reason, Homebrew is not installed.
[[ ! $(command -v brew) ]] && e_error "Homebrew failed to install." && return 1

e_arrow "Updating Homebrew"
brew doctor
brew update
brew bundle --file "$DOTFILES/brew/Brewfile-osx"
