The .service file is for systemd
The .conf file is for nginx

Use these commands to get code-server running:

> mkdir ~/code-server
> cd ~/code-server
> wget https://github.com/cdr/code-server/releases/download/3.9.3/code-server-3.9.3-linux-x86_64.tar.gz
> tar -xzvf code-server-3.9.3-linux-x86_64.tar.gz
> sudo cp -r code-server-3.9.3-linux-x86_64 /usr/lib/code-server
> sudo ln -s /usr/lib/code-server/code-server /usr/bin/code-server
> sudo mkdir /var/lib/code-server
> cp ~/.dotfiles/extra/code-server/code-server.service /etc/systemd/system/code-server.service
> cp ~/.dotfiles/extra/code-server/code-server.conf /etc/nginx/sites-available/code-server.conf
> systemctl enable code-server
> systemctl start code-server
