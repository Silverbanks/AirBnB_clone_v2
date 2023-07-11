#!/usr/bin/env bash
# Set up server file system for deployment

# install nginx
apt-get -y update
apt-get -y install nginx
service nginx start

# configure file system
mkdir -p /data/web_static/shared/
mkdir -p /data/web_static/releases/test/
echo "<!DOCTYPE html>
<html>
  <head>
  </head>
  <body>
    Holberton School
  </body>
</html>" > /data/web_static/releases/test/index.html > /dev/null
sed -i '/server_name _/a location /redirect_me { rewrite ^ https://www.youtube.com/channel/UCOGuCTcfkhxVZSSPyC-Iq1A permanent; }' /etc/nginx/sites-available/default
ln -sf /data/web_static/releases/test/ /data/web_static/current

# set permissions
chown -R ubuntu:ubuntu /data/

# configure nginx
sed -i '/listen 80 default_server/a location /hbnb_static {\n\t\talias /data/web_static/current/;\n\t}' /etc/nginx/sites-available/default

# restart web server
service nginx restart
