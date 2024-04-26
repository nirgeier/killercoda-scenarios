#!/bin/bash

###
### Create the user
###
sudo useradd -m agent
su - agent

###
### Create the agent directory
###
cd    /home/agent

###
### Download the agent
###
wget  https://vstsagentpackage.azureedge.net/agent/3.239.1/vsts-agent-linux-x64-3.239.1.tar.gz -O agent.tar.gz

###
### Extract the agent
###
tar   zxvf agent.tar.gz
./config.sh 
./run.sh
