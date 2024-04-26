#!/bin/bash

# Add python ppa
sudo add-apt-repository -y ppa:deadsnakes/ppa

# Install the required packages
apt update 
#UCF_FORCE_CONFFOLD=1 apt upgrade -y
apt install -y curl tree docker ansible

#pip install -U pip setuptools
# pip install         \
#     ansible-core    \
#     ansible-lint    \
#     molecule        \
#     molecule-docker \
#     yamllint 

# Verify the installed packages
ansible --version
docker  -v

# Download docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.27.0/docker-compose-linux-x86_64" -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose

# Build the docker containers for the labs
source  /kata/killercoda-scenarios/Ansible/bin/install-docker-compose.sh 
cd      /kata/AnsibleLabs/Labs/000-setup/
source  ./_setup.sh