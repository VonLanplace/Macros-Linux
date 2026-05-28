#!/usr/bin/env bash
##########
# 15.5.1 #
##########

sudo apt update
sudo apt install net-tools -y
sudo apt install openssh-server -y

sudo aied validar 57671beb checkpoint01 | tee ~/15.5.1
