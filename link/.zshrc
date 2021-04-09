# Where the magic happens.
export DOTFILES=~/.dotfiles

# Source all files in "source"
function src() {
    local file
    if [[ "$1" ]]; then
        source "$DOTFILES/source/$1.sh"
    else
        for file in $DOTFILES/source/*; do
            source "$file"
        done
    fi
}

src

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/root/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/root/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/root/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/root/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
