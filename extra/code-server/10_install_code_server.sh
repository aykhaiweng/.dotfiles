#!/usr/bin/env bash

CODE_SERVER_VERSION="3.9.3"
CODE_SERVER_DOWNLOAD_URL="https://github.com/cdr/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server-${CODE_SERVER_VERSION}-linux-amd64.tar.gz"

echo "> Downloading from $CODE_SERVER_DOWNLOAD_URL"
# Download the specified version of code-server
wget "$CODE_SERVER_DOWNLOAD_URL" -O "/tmp/code-server-$CODE_SERVER_VERSION-linux-amd64.tar.gz"
# Extra the code-server tar
tar -xzf "/tmp/code-server-$CODE_SERVER_VERSION-linux-amd64.tar.gz" -C /tmp/
# Check for an existing installation
if [[ -d "/usr/lib/code-server/" ]]; then
    # Remove if we can find it
    echo "> Deleting existing version of code-server"
    rm -r /usr/lib/code-server/
fi
# Copy the recently downloaded version of code-server
cp -r "/tmp/code-server-$CODE_SERVER_VERSION-linux-amd64" /usr/lib/code-server

# Check if the symlink exists
if [[ -f "/usr/bin/code-server" ]]; then
    # Delete the symlink if it already exists
    echo "> Deleting existing link of code-server"
    rm /usr/bin/code-server
fi
sudo ln -s /usr/lib/code-server/bin/code-server /usr/bin/code-server
