#!/usr/bin/env bash

CODE_SERVER_GIT="git@github.com:cdr/code-server.git"
CODE_SERVER_GIT_DIR="/tmp/code-server-git/"

echo "> Cloaning $CODE_SERVER_GIT"
if [[ -d $CODE_SERVER_GIT_DIR ]]; then
    git clone git@github.com:cdr/code-server.git $CODE_SERVER_GIT_DIR
    cd $CODE_SERVER_GIT_DIR
else
    cd $CODE_SERVER_GIT_DIR
    git fetch && git pull
fi


yarn
yarn task build:server:binary


# Exit
cd -
