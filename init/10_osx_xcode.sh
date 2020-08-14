# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Some tools look for XCode, even though they don't need it.
# https://github.com/cowboy/dotfiles#os-x-notes
if [[ -d "$('xcode-select' -print-path 2>/dev/null)" ]]; then
    e_arrow "XCode Command Line Tools is already installed"
else
    e_success "Installing XCode Command Line Tools"
    sudo xcode-select -switch /Library/Developer/CommandLineTools
fi
