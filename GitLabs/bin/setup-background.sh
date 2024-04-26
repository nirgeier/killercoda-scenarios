#!/bin/bash

mkdir -p  /kata   
cd        /kata   

rm -rf AnsibleLabs
rm -rf killercoda-scenarios

git clone --depth 1 https://github.com/nirgeier/DockerLabs.git          
#git clone --depth 1 https://github.com/nirgeier/killercoda-scenarios.git 
