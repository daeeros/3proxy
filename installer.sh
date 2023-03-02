#!/bin/bash
if [ "$#" -ne 2 ]; then
echo "Usage: $0 username password"
exit 1
fi

apt-get update && apt-get -y upgrade
apt-get install gcc make git -y
git clone https://github.com/z3apa3a/3proxy
cd 3proxy
ln -s Makefile.Linux Makefile
make
sudo make install
echo "" > /etc/3proxy/conf/passwd && echo "$1:CL:$2" >> /etc/3proxy/conf/passwd
ufw allow 22/tcp
ufw allow 3128/tcp
yes | ufw enable
reboot
