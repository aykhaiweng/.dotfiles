#!/bin/bash
trap "exit" INT

# declare current directory
export SETUP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

_prompt_sudo() {
    # Prompt for sudo
    sudo -v
}

_echo() {
    # Different echo colored based on the OS installed
    echo "[aykhaiweng says] - $1"
}

_check_pyenv_versions() {
    # Check if the pyenv is installed
    local __result_var=$1
    if [[ $(pyenv versions | grep $2) ]]; then
        local __pyenv_exists=true
    else
        local __pyenv_exists=false
    fi

    eval $__result_var=$__pyenv_exists
}


main() {
    # prompt for sudo
    _echo "Before I start installing anything, I'm going to need your password for sudo access."
    _prompt_sudo

    # declare variable for os type
    uname=$(uname)
    _echo "$uname detected."
    if [[ $uname == 'Darwin' ]]; then
        _echo "Setting up for Darwin platform."
        export PYTHON_CONFIGURE_OPTS="--enable-framework"
        source $SETUP_DIR/osx/install.sh
    elif [[ $uname == 'Linux' ]] || [[ $uname == '' ]]; then
        _echo "Setting up for Linux platform."
        export PYTHON_CONFIGURE_OPTS="--enable-shared"
        source $SETUP_DIR/linux/install.sh
    else
        _echo "Your platform is not supported yet."
    fi

    # Installing .oh-my-zsh stuff
    _echo "Installing .oh-my-zsh"
    git clone git://github.com/aykhaiweng/oh-my-zsh.git $HOME/.oh-my-zsh
    _echo "Installing zsh-competions"
    git clone https://github.com/zsh-users/zsh-completions $HOME/.oh-my-zsh/custom/plugins/zsh-completions
    _echo "Installing zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/plugins/zsh-autosuggestions


    # updating pip and it's prerequisites
    _echo "Upgrading pip and installing prerequisites."
    sudo pip3 install --upgrade pip
    sudo pip3 install pipenv
    # prepare to symlink the files
    _echo "Now preparing to symlink files."
    python3 $SETUP_DIR/symlink.py
    # run the aliases file to get the pyenv out
    _echo "Running the $HOME/.aliases file that we symlinked earlier"
    source ~/.aliases

    # npm
    sudo npm install -g typescript
    sudo npm install -g xbuild
    sudo npm install -g neovim
    sudo npm install -g graceful-fs

    source $HOME/.aliases
    if [[ $uname == 'Darwin' ]]; then
        export PYTHON_CONFIGURE_OPTS="--enable-framework"
    elif [[ $uname == 'Linux' ]]; then
        export PYTHON_CONFIGURE_OPTS="--enable-shared"
    else
        _echo "Your platform is not supported yet."
    fi

    PYTHON3_VER="3.8.1"

    # FZF STUFF
    _echo "Installing FZF"
    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    $HOME/.fzf/install --all


    # TMUX STUFF
    _echo "Downloading tpm for Tmux!"
    git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
    _echo "Downloading tmux-gitbar"
    source $SETUP_DIR/extras/install-tmux-gitbar.sh

    # Installing vim plug
    _echo "Installing vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    # Installing vim plugins
    _echo "Installing VIM Plugins..."
    nvim +PlugInstall +qa!
    vim +PlugInstall +qa!

    # Installing Poetry
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python

    # Installing KR
    curl https://krypt.co/kr | sh

    # Install Rmate
    sudo curl -o /usr/local/bin/rmate https://raw.githubusercontent.com/aurora/rmate/master/rmate
    sudo chmod +x /usr/local/bin/rmate

    # SSH STUFF
    # create an id_rsa file if it doesn't already exist
    if [ ! -f $HOME/.ssh/id_ed25519 ]; then
        ssh-keygen -f $HOME/.ssh/id_ed25519 -t ed25519 -N ''
        _echo "A ssh-key with the default name ($HOME/.ssh/id_ed25519) has been created for you!"
        _echo "Here is the key:"
        echo "$(cat $HOME/.ssh/id_ed25519.pub)"
    fi

    # finalize
    _echo "Reloading $HOME/.zshrc."
    exec "$SHELL"
    source $HOME/.zshrc
    _echo ".dotfiles setup complete! Enjoy."
}

# invoke main
main
