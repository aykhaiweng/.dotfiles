#!/usr/bin/env bash

# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

export DEBIAN_FRONTEND=noninteractive 

# Setting up the Timezone data
e_arrow "Updating apt"
ln -fs /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime
sudo dpkg-reconfigure --frontend noninteractive tzdata

# General install
e_arrow "Updating apt"
sudo apt update -y
sudo apt upgrade -y
e_success "Installing essentials"
sudo apt install -y  --assume-yes apt-transport-https build-essential curl wget file software-properties-common make build-essential libssl-dev zlib1g-dev libbz2-dev cmake zsh tmux neovim xclip node silversearcher-ag bat

# Install Docker
e_arrow "Installing Docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update -y
apt-cache policy docker-ce
sudo apt install docker-ce docker-compose -y

# Install pyenv
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
exec $SHELL
