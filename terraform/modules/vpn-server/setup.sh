#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y openvpn easy-rsa 

wget https://git.io/vpn -O openvpn-install.sh
chmod +x openvpn-install.sh
sudo ./openvpn-install.sh