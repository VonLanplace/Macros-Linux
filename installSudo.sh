#!/usr/bin/env bash

######################
# Instalação do Sudo #
######################
apt update -y
apt install sudo -y
if ! grep -q "userlinux ALL=(ALL:ALL) ALL" /etc/sudoers; then
    echo "userlinux ALL=(ALL:ALL) ALL" >> /etc/sudoers
fi

##########################
# Instalação componentes #
##########################
sudo apt update && sudo apt install build-essential g++ gcc libblkid-dev libsfml-dev libcurl4-openssl-dev curl wget iputils-ping iputils-tracepath net-tools lm-sensors git openssh-server ansifilter -y
sudo systemctl enable --now ssh

#
#
#
sudo chmod -R 777 $(pwd)

su - $(id -nu 1000)
exit
