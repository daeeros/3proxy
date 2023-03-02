#!/bin/bash

apt-get update && apt-get -y upgrade
apt-get install gcc make git -y
git clone https://github.com/z3apa3a/3proxy
cd 3proxy
ln -s Makefile.Linux Makefile
make
sudo make install

echo ""
read -p "Enter the username: " username
read -sp "Enter the password: " password
echo ""
read -p "Enter the port number (default: 3128): " port
port=${port:-3128}

echo "" > /etc/3proxy/conf/passwd && echo "$username:CL:$password" >> /etc/3proxy/conf/passwd

current_ipv4=$(curl -s https://api.ipify.org)

echo ""
echo "Proxy link: http://$username:$password@$current_ipv4:$port"
echo ""

echo "proxy -n -p$port -a" >> /etc/3proxy/conf/3proxy.cfg

ufw allow 22/tcp
ufw allow $port/tcp
yes | ufw enable
reboot
