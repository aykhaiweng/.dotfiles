FROM ubuntu
MAINTAINER Au Yeong Khai Weng

# OS updates and install
RUN apt-get -qq update
RUN apt-get install git sudo zsh -qq -y

# Create test user and add to sudoers
RUN useradd -m -s /bin/zsh aykhaiweng
RUN usermod -aG sudo aykhaiweng
RUN echo "aykhaiweng   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

# Add dotfiles and chown
ADD . /home/aykhaiweng/tmp/dotfiles
RUN chown -R aykhaiweng:aykhaiweng /home/aykhaiweng

# Switch aykhaiweng
USER aykhaiweng
ENV HOME /home/aykhaiweng

# Change working directory
WORKDIR /home/aykhaiweng/tmp/dotfiles

# Run setup
RUN ./bin/dotfiles

CMD ["/bin/bash"]