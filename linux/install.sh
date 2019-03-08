#!/bin/bash

###############################################################################
# Linux Setup
###############################################################################


# Get the color definitions
source colordefinitions.sh

_echo() {
    echo "[${LIGHTCYAN}aykhaiweng${NOCOLOR} says] [${ORANGE}LINUX${NOCOLOR}] - $1"
}

DBPASSWRD = 'topkek'


# prompt for sudo
sudo -v


main() {
    # Install essentials
    _echo "Installing essentials."
    _echo
    echo "@================================================="
    echo "| khai.IO                                        |"
    echo "|                                                |"
    echo "| The following programs will be                 |"
    echo "| installed:-                                    |"
    echo "|    1. python3              8. nginx            |"
    echo "|    2. python3-pip          9. gunicorn         |"
    echo "|    3. python-dev           10. git             |"
    echo "|    4. libpq-dev            11. memcached       |"
    echo "|    5. postgresql           12. system-services |"
    echo "|    6. mysql                13. nodejs-legacy   |"
    echo "|    7. libjpeg8-dev         14. npm             |"
    echo "|                                                |"
    echo "|                    And loads of other goodies! |"
    echo "@================================================="
    echo

    sudo apt update -y
    sudo apt install apt-transport-https -y
    sudo apt upgrade -y
    sudo apt install build-essential curl file -y
    sudo apt install make build-essential libssl-dev zlib1g-dev libbz2-dev -y
    sudo apt install ca-certificates software-properties-common -y
    sudo apt install libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev -y
    sudo apt install xz-utils tk-dev libffi-dev liblzma-dev python-openssl -y
    sudo apt install systemd -y
    sudo apt install git python3-pip python-dev python-setuptools python-docutils -y
    sudo apt install nginx gunicorn memcached -y
    sudo apt install libpq-dev postgresql postgresql-contrib gettext -y
    sudo apt install postgis binutils gdal-bin -y
    sudo apt install nodejs npm -y
    sudo apt install libjpeg8-dev -y
    sudo apt install sqlite3 libsqlite3-dev -y
    sudo apt install autotools-dev autoconf -y
    sudo apt install libffi-dev libssl-dev libxml2-dev libxslt1-dev -y

    # Install KVM
    sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virt-manager -y
    sudo modprobe vhost_net 
    sudo lsmod | grep vhost 
    if ! [ $KURA_FTS ] ; then
        echo "vhost_net" | sudo tee -a /etc/modules
        echo "iface eth0 inet manual" | sudo tee -a /etc/network/interfaces
        echo "iface br0 inet dhcp" | sudo tee -a /etc/network/interfaces
        echo "    bridge_ports eth0" | sudo tee -a /etc/network/interfaces
        if [ $USER != "root" ] ; then
            sudo adduser $USER libvirt
            sudo adduser $USER libvirt-qemu
        fi
    fi

    # Install Docker
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
    sudo apt update
    apt-cache policy docker-ce
    sudo apt install docker-ce -y

    # Install Vagrant
    sudo apt install vagrant -y

    # Install Ansible
    sudo apt install ansible -y

    # Letsencrypt
    sudo apt install letsencrypt -y

    # The Silver Searcher
    sudo apt install silversearcher-ag -y

    # terminal essentials
    sudo apt install cmake zsh tmux xclip -y
    sudo apt install mosh -y

    # neovim installation
    sudo apt install neovim -y

    if ! [ $KURA_FTS ] ; then
        _echo "Setting up locales"
        sudo locale-gen en_US.UTF-8
        sudo timedatectl set-timezone Asia/Kuala_Lumpur
    fi

    sudo -u postgres psql -c "create user $USER WITH SUPERUSER PASSWORD 'topkek';" postgres

    # installing pyenv
    _echo "Installing pyenv"
    git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
    git clone https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv
}

# invoke main
main
