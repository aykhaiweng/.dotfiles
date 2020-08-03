###########################################
# GENERAL PURPOSE EXPORTED VARS / FUNCTIONS
###########################################
export DOTFILES=~/.dotfiles

# encoding
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="UTF-8"

# colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# Logging stuff.
function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()    { echo -e " \033[1;34m➜\033[0m  $@"; }

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

is_osx && export DIRECTORY_COLOR_ARGUMENTS="-CF"
is_ubuntu && export DIRECTORY_COLOR_ARGUMENTS="--color=always"

alias ls='ls -A $DIRECTORY_COLOR_ARGUMENTS'
alias ll='ls -Al'