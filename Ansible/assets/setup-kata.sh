#!/bin/bash

# Load the colors palette
source <(curl -s https://raw.githubusercontent.com/nirgeier/labs-assets/refs/heads/main/assets/scripts/colors.sh)

# Download docker-compose
echo -e "${YELLOW} * Downloading latest docker-compose ${COLOR_OFF}"
# Add Docker's official GPG key
sudo apt-get update > /dev/null 2>&1
sudo apt-get install ca-certificates curl gnupg > /dev/null 2>&1
sudo install -m 0755 -d /etc/apt/keyrings > /dev/null 2>&1
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg > /dev/null 2>&1
sudo chmod a+r /etc/apt/keyrings/docker.gpg > /dev/null 2>&1

# Add the repository to Apt sources
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null > /dev/null 2>&1

# Add python ppa
echo -e "${YELLOW} * Installing required python packages ${COLOR_OFF}"
sudo add-apt-repository -y ppa:deadsnakes/ppa > /dev/null 2>&1

# Install the required packages
apt update > /dev/null 2>&1
apt install -y curl tree docker docker-compose-plugin ansible zsh > /dev/null 2>&1
pip install -U pip setuptools > /dev/null 2>&1
pip install         \
    ansible-core    \
    ansible-lint    \
    molecule        \
    molecule-docker \
    yamllint > /dev/null 2>&1

# Verify the installed packages
echo -e "${YELLOW} ---------------------------------------- ${COLOR_OFF}"
echo -e "${YELLOW} * Checking Ansible version ${COLOR_OFF}"
ansible --version
echo -e "${YELLOW} ---------------------------------------- ${COLOR_OFF}"
echo -e "${YELLOW} * Checking Docker version ${COLOR_OFF}"
docker  -v

echo -e "${YELLOW} * Cloning the AnsibleLabs repository ${COLOR_OFF}"
rm -rf ~/AnsibleLabs            > /dev/null 2>&1
git init ~/AnsibleLabs          > /dev/null 2>&1
cd ~/AnsibleLabs                > /dev/null 2>&1    
git remote add origin https://github.com/nirgeier/AnsibleLabs.git   > /dev/null 2>&1
git config --global core.sparseCheckout true                        > /dev/null 2>&1
echo "Labs"     >  .git/info/sparse-checkout 
echo "_utils"   >> .git/info/sparse-checkout 
git pull origin main            > /dev/null 2>&1

cd ~/AnsibleLabs/Labs/000-setup/
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended > /dev/null 2>&1
zsh

clear
echo -e "${YELLOW}AnsibleLabs folder containers the required labs ${COLOR_OFF}"

