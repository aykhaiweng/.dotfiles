FROM ubuntu
MAINTAINER Au Yeong Khai Weng <aykhaiweng@gmail.com>

# OS updates and install
RUN apt-get -qq update
RUN apt-get install sudo apt-utils -qq -y

# Create test user and add to sudoers
RUN useradd -m aykhaiweng
RUN usermod -aG sudo aykhaiweng
RUN echo "aykhaiweng   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

# Add dotfiles and chown
ADD . /home/aykhaiweng/.dotfiles
RUN chown -R aykhaiweng:aykhaiweng /home/aykhaiweng

# Switch aykhaiweng
USER aykhaiweng
ENV HOME /home/aykhaiweng

ENTRYPOINT ["/bin/bash", "/home/aykhaiweng/.dotfiles/bin/dotfiles"]
