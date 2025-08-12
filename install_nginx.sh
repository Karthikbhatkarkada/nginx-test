#!/bin/bash
set -e

echo "Updating packages..."
sudo apt-get update -y

echo "Installing dependencies..."
sudo apt-get install -y build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev git

echo "Fetching NGINX source from GitHub..."
git clone https://github.com/<your-username>/<your-nginx-repo>.git /tmp/nginx-src

echo "Installing NGINX..."
cd /tmp/nginx-src
./configure
make
sudo make install

echo "Copying custom nginx.conf..."
sudo cp /tmp/nginx-src/nginx.conf /usr/local/nginx/conf/nginx.conf

echo "Creating NGINX systemd service..."
cat <<EOF | sudo tee /etc/systemd/system/nginx.service
[Unit]
Description=NGINX server
After=network.target

[Service]
Type=forking
ExecStart=/usr/local/nginx/sbin/nginx
ExecReload=/usr/local/nginx/sbin/nginx -s reload
ExecStop=/usr/local/nginx/sbin/nginx -s quit
PIDFile=/usr/local/nginx/logs/nginx.pid
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl enable nginx
