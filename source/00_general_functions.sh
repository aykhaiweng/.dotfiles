#!/usr/bin/env bash

###########################################
# GENERAL PURPOSE EXPORTED VARS / FUNCTIONS
###########################################
export DOTFILES=~/.dotfiles

# colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# configuration options for pyenv
export PYTHON_CONFIGURE_OPTS="--enable-framework"

# Add path to to dotfiles/bin
[[ -d $DOTFILES/bin ]] && export PATH=$DOTFILES/bin:$PATH  # Add the dotfiles' bin folder
[[ -d $HOME/.local/bin ]] && export PATH=$HOME/.local/bin:$PATH  # Add a .local/bin to the path if found

# Logging stuff.
function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()    { echo -e " \033[1;34m➜\033[0m  $@"; }
function p_arrow()    { read -p " \033[1;34m➜\033[0m  $@"; }

# OS detection
function is_osx() {
    [[ "$OSTYPE" =~ ^darwin ]] || return 1
}
function is_ubuntu() {
    [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1
}
function is_ubuntu_desktop() {
    dpkg -l ubuntu-desktop >/dev/null 2>&1 || return 1
}
function get_os() {
    for os in osx ubuntu ubuntu_desktop; do
        is_$os; [[ $? == ${1:-0} ]] && echo $os
    done
}

# Shell detection
function is_bash() {
    [[ -n "$BASH_VERSION" ]] || return 1
}
function is_zsh() {
    [[ -n "$ZSH_VERSION" ]] || return 1
}

# File detection
function is_symlink() {
    [[ -L $1 ]] && return 1
}
function is_file() {
    [[ -f $1 ]] && return 1
}
function is_directory() {
    [[ -d $1 ]] && return 1
}
