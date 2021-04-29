#!/usr/bin/env sh

docker run -d -p 59996:8080 --name=adminer --restart=always -e ADMINER_DEFAULT_SERVER=postgresql adminer
