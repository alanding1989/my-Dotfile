#! /usr/bin/env bash


# File Name    : extools/tools/install-docker.sh
# Author       : AlanDing
# Created Time : Thu 26 Sep 2019 10:13:58 PM CST
# Description  : 


# path=/mnt/fun+downloads/linux系统安装/code-software/system-util/
#
# dpkg -i $(ls "$path" | grep docker) || exit 1

# deps
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

newgrp docker
sudo groupadd docker
sudo usermod -aG docker alanding

sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
