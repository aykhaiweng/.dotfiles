#!/usr/bin/env bash

# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

export DEBIAN_FRONTEND=noninteractive

# General install
e_arrow "Updating apt"
sudo apt update -y
sudo apt autoremove -y
sudo apt upgrade -y
e_success "Installing essentials"
sudo apt install -y --assume-yes \
    apt-transport-https curl \
    wget gnupg-agent \
    ca-certificates libssl-dev \
    software-properties-common make cmake build-essential \
    zlib1g-dev libbz2-dev libffi-dev libc6-dev \
    # libreadline-dev libsqlite3-dev
    # zsh tmux vim neovim xclip nodejs silversearcher-ag bat

# Install Docker
e_arrow "Installing Docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -  # Docker's official GPG key
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get install docker-ce docker-ce-cli containerd.io

# Install pyenv
if [[ -d "$HOME/.pyenv" ]]; then
    e_arrow "pyenv is already installed"
else
    e_success "Installing pyenv"
    curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
fi
