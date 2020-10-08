#!/usr/bin/env bash

# encoding
is_osx && export LC_ALL="C.UTF-8"
is_osx && export LC_CTYPE="UTF-8"
is_osx || export LC_ALL="C.UTF-8"
is_osx || export LC_CTYPE="UTF-8"
