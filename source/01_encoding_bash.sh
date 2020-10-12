#!/usr/bin/env bash

# encoding
is_osx && export LC_ALL="en_US.UTF-8"
is_osx && export LC_CTYPE="en_US.UTF-8"
is_osx || export LC_ALL="C.UTF-8"
is_osx || export LC_CTYPE="UTF-8"
