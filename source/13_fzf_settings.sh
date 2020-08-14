#!/usr/bin/env bash

# export FZF_DEFAULT_COMMAND="ag --ignore '*.pyc' --ignore '*/*.pyc' --ignore-dir '*pycache*' --ignore-dir '.tox' --hidden --skip-vcs-ignores -g ''"
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 50% --layout=reverse --border=rounded --inline-info --preview "head -100 {}"'
