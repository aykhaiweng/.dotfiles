FROM ubuntu:focal
LABEL maintainer="aykhaiweng@gmail.com" \
      description="Testing the build on the setup.sh"

RUN apt-get update
RUN apt-get -y install sudo

RUN mkdir -p /opt/testing/
COPY . /opt/testing/

RUN chmod +x /opt/testing/setup.sh

ENTRYPOINT /bin/bash -c '/opt/testing/setup.sh'
