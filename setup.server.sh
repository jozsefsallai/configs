#!/bin/bash

echo "Are you sure you want to set up your server environment? This might overwrite things! (Ctrl+C to cancel)"  && read

echo "\n\n* * * Copying dotfiles * * *\n"

cp .bashrc ~/.bashrc
cp .zshrc ~/.zshrc
cp .npmrc ~/.npmrc

source ~/.bashrc

echo "* * * Switching to Debian sid * * *"

sudo sed -i '/deb.debian.org/d' /etc/apt/sources.list
sudo echo "deb http://deb.debian.org/debian sid main" >> /etc/apt/sources.list

echo "\n\n* * * Upgrading packages * * *\n"

sudo apt update && sudo apt -y upgrade

echo "\n\n* * * Installing wget, cURL and build-essential * * *\n"

sudo apt install wget curl build-essential

echo "\n\n* * * Installing Node.js * * *\n"

curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install -y nodejs

npm i -g yarn nodemon pm2

echo "\n\n* * * Installing Go * * *\n"

sudo apt install golang go-dep
mkdir -p ~/go ~/go/bin ~/go/pkg ~/go/src

echo "\n\n* * * Installing Python3 * * *\n"

sudo apt install python3

echo "\n\n* * * Installing nginx * * *\n"

sudo apt install nginx

echo "\n\n* * * Installing Certbot * * *\n"

sudo apt install python3-certbot python3-certbot-nginx python3-certbot-dns-cloudflare

echo "\n\n* * * Installing ufw * * *\n"

sudo apt install ufw

echo "\n\n* * * Allowing ports 80, 443, 22 and enabling ufw * * *\n"

sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow 22

sudo ufw enable

echo "\n\n* * * Installing other stuff * * *\n"

sudo apt install \
  neofetch \
  sl

echo "\n\n* * * Generating ssh key * * *\n"

ssh-keygen -t rsa -b 4096

echo "\n\nAll done!"
