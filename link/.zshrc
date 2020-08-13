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
# End