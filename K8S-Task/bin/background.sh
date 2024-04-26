#!/bin/bash

mkdir -p  /kata   
cd        /kata   

rm -rf K8S_Task
rm -rf killercoda-scenarios

git clone --depth 1 https://github.com/nirgeier/K8S_Task.git