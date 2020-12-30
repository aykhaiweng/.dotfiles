#!/usr/bin/env bash

# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
