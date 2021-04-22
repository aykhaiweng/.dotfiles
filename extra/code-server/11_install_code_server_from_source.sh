#!/usr/bin/env bash

CODE_SERVER_GIT="git@github.com:cdr/code-server.git"
CODE_SERVER_GIT_DIR="$HOME/repos/code-server-git/"

# Cloning or updating the git
if [[ ! -d $CODE_SERVER_GIT_DIR ]]; then
    echo "> Cloning $CODE_SERVER_GIT into $CODE_SERVER_GIT_DIR"
    mkdir -p $CODE_SERVER_GIT_DIR
    git clone git@github.com:cdr/code-server.git $CODE_SERVER_GIT_DIR --depth 1
    cd $CODE_SERVER_GIT_DIR
else
    echo "> Updating existing at $CODE_SERVER_GIT_DIR"
    cd $CODE_SERVER_GIT_DIR
    git fetch && git pull
fi


yarn build
yarn build:vscode
yarn release


# Exit
cd -
