#!/bin/bash
trap "exit" INT

# Get the color definitions
source colordefinitions.sh

# declare current directory
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

_prompt_sudo() {
    # Prompt for sudo
    sudo -v
}

_echo() {
    # Different echo colored based on the OS installed
    echo "[${LIGHTCYAN}aykhaiweng${NOCOLOR} says] - $1"
}


main() {
    # prompt for sudo
    _echo "Before I start installing anything, I'm going to need your password for sudo access."
    _prompt_sudo

    _echo "Time to install some scripts!"
    find scripts -mindepth 1 -name "*" -exec ln -vs "{}" /usr/local/bin/ \;

}

# invoke main
main
