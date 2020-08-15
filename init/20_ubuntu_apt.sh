#!/usr/bin/env bash

# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

# Disable frontend for some installers
export DEBIAN_FRONTEND=noninteractive

# Commands
apt_ppa=()
apt_packages=(
    apt-transport-https
    build-essential
    gnupg-agent
    ca-certificates 
    software-properties-common
    make
    cmake
    zlib1g-dev
    libbz2-dev
    libffi-dev
    libc6-dev
    libssl-dev
    libreadline-dev
    libsqlite3-dev
    wget
    zsh
    xclip
    nodejs
    silversearcher-ag
    bat
    fzf
)

# General install
e_arrow "Running apt update"
sudo apt update -y
e_arrow "Running apt autoremove"
sudo apt autoremove -y
e_arrow "Running apt upgrade"
sudo apt upgrade -y

# Latest vim
apt_ppa+=("ppa:jonathonf/vim")
apt_packages+=(vim)

# Latest neovim
apt_ppa+=("ppa:neovim-ppa/unstable")
apt_packages+=(neovim)

# Docker
e_arrow "Installing Docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -  # Docker's official GPG key
apt_ppa+=("deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable")
apt_packages+=(docker.io)
apt_packages+=(docker-compose)

# Adding apt repositories
e_arrow "Adding apt repositories"
for entry in "${apt_ppa[@]}"; do
    sudo add-apt-repository $entry
done

# Install the apt packages
e_arrow "Installing apt packages"
for entry in "${apt_packages[@]}"; do
    sudo apt install -qy $entry
done

# Install pyenv
if [[ -d "$HOME/.pyenv" ]]; then
    e_arrow "pyenv is already installed"
else
    e_success "Installing pyenv"
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
fi
