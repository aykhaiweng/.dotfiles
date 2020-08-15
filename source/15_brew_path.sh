#!/usr/bin/env bash

return 1
is_ubuntu || return 1

export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
