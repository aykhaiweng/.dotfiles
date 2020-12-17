#!/usr/bin/env bash

# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1


# Installing docker-compose
EXISTING_DOCKER_COMPOSE=$(which docker-compose | grep /)
if [[ $EXISTING_DOCKER_COMPOSE ]]; then
    rm $EXISTING_DOCKER_COMPOSE
fi
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
chmod +x /usr/bin/docker-compose
