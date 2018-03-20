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

	debconf-set-selections <<< "mysql-server mysql-server/root_password password $DBPASSWD"
	debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $DBPASSWD"

	sudo apt-get update
	sudo apt-get install build-essential curl file git -y
	sudo apt-get install vim systemd -y
	sudo apt-get install git python3-pip python-dev python-setuptools -y
	sudo apt-get install nginx gunicorn memcached -y
	sudo apt-get install libpq-dev postgresql postgresql-contrib gettext -y
	sudo apt-get install nodejs-legacy npm libjpeg8-dev -y
	# sudo apt-get install postfix mailutils libsasl2-2 ca-certificates libsasl2-modules -y
	sudo apt-get install libffi-dev libssl-dev libxml2-dev libxslt1-dev -y
	# sudo apt-get install letsencrypt -y
	sudo apt-get install mysql-server libmysqlclient-dev -yq

	# terminal essentials
	sudo apt-get install cmake zsh tmux xclip -y

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
