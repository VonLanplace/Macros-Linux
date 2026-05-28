#!/usr/bin/env bash

######################
# Instalação do Sudo #
######################
apt update -y
apt install sudo -y
if ! grep -q "userlinux ALL=(ALL:ALL) ALL" /etc/sudoers; then
    echo "userlinux ALL=(ALL:ALL) ALL" >> /etc/sudoers
fi

chmod -R 777 $(pwd)

su - $(id -nu 1000)
exit
