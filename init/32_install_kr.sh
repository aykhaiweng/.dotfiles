#!/usr/bin/env bash

if [[ ! $(which kr) ]]; then
	e_arrow "Installing Krypton from https://krypt.co/kr"
	curl https://krypt.co/kr | sh
fi