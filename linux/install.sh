#!/bin/bash

###############################################################################
# Linux Setup
###############################################################################

_echo() {
    echo "[aykhaiweng says] [LINUX] - $1"
}

_append_to_file() {
    string=$1
    filepath=$2
    attr=$(grep -Fx "$string" $filepath)
    if [ $attr ] ; then
        echo "[FOUND] '$string' in '$filepath'"
    else
        echo "[APPEND] '$string' to '$filepath'"
        echo "$string" | sudo tee -a $filepath
    fi
}

DBPASSWRD='topkek'


# prompt for sudo
sudo -v


main() {
    if ! [ $KURA_FTS ] ; then
        _echo "Setting up locales"
        sudo locale-gen en_US.UTF-8
        sudo timedatectl set-timezone Asia/Kuala_Lumpur
    fi

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
    echo "|    5. NO MORE POSTGRESQL   12. system-services |"
    echo "|    6. NO MORE MYSQL        13. nodejs-legacy   |"
    echo "|    7. libjpeg8-dev         14. npm             |"
    echo "|                                                |"
    echo "|                    And loads of other goodies! |"
    echo "@================================================="
    echo

    sudo apt update -y
    sudo apt install apt-transport-https -y
    sudo apt upgrade -y
    _echo "Installing essentials"
    sudo apt install -y  --assume-yes build-essential curl wget file \
        ca-certificates software-properties-common \
        make build-essential libssl-dev zlib1g-dev libbz2-dev \
        autotools-dev autoconf \
        libffi-dev libssl-dev libxml2-dev libxslt1-dev \
        libreadline-dev libncurses5-dev libncursesw5-dev llvm \
        libffi-dev liblzma-dev python-openssl xz-utils tk-dev \
        libpq-dev gettext \
        libjpeg8-dev \
        byacc binutils gdal-bin \
        silversearcher-ag \
        cmake zsh tmux xclip \

    # Install KVM
    _echo "Installing KVM"
    sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virt-manager -y
    sudo modprobe vhost_net 
    sudo lsmod | grep vhost 
    if ! [ $KURA_FTS ] ; then
        _echo "Setting up KVM"
        # echo "vhost_net" | sudo tee -a /etc/modules
        # echo "iface eth0 inet manual" | sudo tee -a /etc/network/interfaces
        # echo "iface br0 inet dhcp" | sudo tee -a /etc/network/interfaces
        # echo "    bridge_ports eth0" | sudo tee -a /etc/network/interfaces
        _append_to_file "vhost_net" "/etc/modules"
        _append_to_file "iface eth0 inet manual" "/etc/network/interfaces"
        _append_to_file "iface br0 inet dhcp" "/etc/network/interfaces"
        _append_to_file "    bridge_ports eth0" "/etc/network/interfaces"
        if [ $USER != "root" ] ; then
            _echo "Adding users for KVM"
            sudo adduser $USER libvirt
            sudo adduser $USER libvirt-qemu
        fi
    fi

    # Install Docker
    _echo "Installing Docker"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
    sudo apt update
    apt-cache policy docker-ce
    sudo apt install docker-ce -y

    # Install Vagrant
    _echo "Installing Vagrant"
    sudo apt install vagrant -y

    # Install Ansible
    _echo "Installing Ansible"
    sudo apt install ansible -y

    # Letsencrypt
    _echo "Installing Letsencrypt"
    sudo apt install letsencrypt -y

    # terminal essentials
    sudo apt install mosh -y

    # neovim installation
    sudo apt install neovim -y

    _echo "Setting up postgresql user for $USER with password 'topkek'"
    sudo -u postgres psql -c "create user $USER WITH SUPERUSER PASSWORD 'topkek';" postgres

    # installing pyenv
    if [ ! -d "$HOME/.pyenv" ] ; then
        _echo "Installing pyenv"
        git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
    fi
    if [ ! -d "$HOME/.pyenv/plugins/pyenv-virtualenv" ] ; then
        _echo "Installing pyenv-virtualenv"
        git clone https://github.com/pyenv/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv
    fi
}

# invoke main
main
