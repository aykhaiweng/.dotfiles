#!/usr/bin/env sh

docker run -d -p 59997:8000 -p 59998:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest
