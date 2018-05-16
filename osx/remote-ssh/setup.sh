#!bin/bash

# declare current directory
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

launchctl load local.pbcopy.plist
launchctl start local.pbcopy
