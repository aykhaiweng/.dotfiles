# ZSH Theme - Preview: http://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png

# New Line
NEWLINE=$'\n'

# The user icon
if [[ $UID -eq 0 ]]; then
    local user_symbol='%B%{$fg[blue]%}λ%b'
else
    local user_symbol='%B%{$fg[magenta]%}λ%b'
fi

if [[ -n "$SSH_CLIENT" ]]; then
    local ssh_host='%B%{$fg[yellow]%}$HOST%b:%{$reset_color%}'
else
    local ssh_host=''
fi

# Local DIR
local current_dir='%B%{$fg[white]%}%~%b%{$reset_color%}'

# Git Branch
local git_branch='$(git_prompt_info)%{$reset_color%}'

# ZSH Git Prompt
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

# Return Code
local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
RPS1="%B${return_code}%b"

precmd() {
    if [[ -n $PYENV_SHELL ]]; then
        local version
        version=${(@)$(pyenv version)[1]}
        if [[ $version = system ]]; then
            local pyenv_version=""
        else
            local pyenv_version="(pyenv $version) "
        fi
    fi

    eval "$PROMPT_COMMAND"
    # PROMPT="${NEWLINE}($(pyenv_prompt_info)) ${current_dir} ${git_branch}${NEWLINE}%B${user_symbol}%{$reset_color%}%b "
    PROMPT="${NEWLINE}($(pyenv_prompt_info)) ${ssh_host}${current_dir} ${git_branch}${NEWLINE}%B${user_symbol}%b "
}
