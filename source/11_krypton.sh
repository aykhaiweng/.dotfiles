#!/usr/bin/env bash

if [[ -f "/usr/bin/kr" || -f "/usr/local/bin/kr" ]]; then
    # Added by Krypton
    export GPG_TTY=$(tty)
fi
