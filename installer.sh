#!/bin/bash

apt-get update && apt-get -y upgrade
apt-get install gcc make git curl -y
git clone https://github.com/z3apa3a/3proxy
cd 3proxy
ln -s Makefile.Linux Makefile
make
sudo make install

echo ""
read -p "Enter the username: " username
read -sp "Enter the password: " password
echo ""

echo "" > /etc/3proxy/conf/passwd && echo "$username:CL:$password" >> /etc/3proxy/conf/passwd

current_ipv4=$(curl -s https://api.ipify.org)

echo ""
echo "Proxy link: http://$username:$password@$current_ipv4:3128"
echo ""

ufw allow 22/tcp
ufw allow 3128/tcp
yes | ufw enable
reboot
