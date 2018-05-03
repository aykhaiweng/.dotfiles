#!/bin/bash

# declare current directory
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CTAGS_DIR="$THIS_DIR/tmp/ctags/"

git clone https://github.com/universal-ctags/ctags.git $CTAGS_DIR
cd $CTAGS_DIR
exec autogen.sh
exec configure
make
make install
cd $THIS_DIR

