#!/usr/bin/env bash

######################
# Instalação do Sudo #
######################
su root
apt update -y
apt install sudo -y
if ! grep -q "userlinux ALL=(ALL:ALL) ALL" /etc/sudoers; then
    echo "userlinux ALL=(ALL:ALL) ALL" >> /etc/sudoers
fi
