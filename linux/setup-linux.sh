# !/bin/bash

###############################################################################
# Linux Setup
###############################################################################

function _echo() {
	echo "[aykhaiweng says][Linux] - $1"
}

# prompt for sudo
sudo -v

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

sudo apt-get update
sudo apt-get install build-essential curl file git -y
sudo apt-get install vim systemd -y
sudo apt-get install git python3-pip python-dev python-setuptools -y
sudo apt-get install nginx gunicorn memcached -y
sudo apt-get install libpq-dev postgresql postgresql-contrib gettext -y
sudo apt-get install nodejs-legacy npm libjpeg8-dev -y
sudo apt-get install postfix mailutils libsasl2-2 ca-certificates libsasl2-modules -y
sudo apt-get install libffi-dev libssl-dev libxml2-dev libxslt1-dev -y
sudo apt-get install letsencrypt -y
sudo apt-get install mysql-server libmysqlclient-dev -y

# terminal essentials
sudo apt-get install zsh tmux xclip -y

if ! [ $KURA_FTS ] ; then
    _echo "Setting up locales"
    sudo locale-gen en_US.UTF-8
    sudo timedatectl set-timezone Asia/Kuala_Lumpur
fi

# sudo -u postgres psql -c "create user $USER superuser password 'oceannexus129';" postgres

if ! [ -f ~/.ssh/id_rsa.pub ]; then
    _echo "Generating SSH Keys"
    ssh-keygen
    echo
fi

# Specifically for servers, this is a requirement
pip install virtualenv

# installing pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
