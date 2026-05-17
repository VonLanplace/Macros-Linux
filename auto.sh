#!/usr/bin/env bash

######################
# Instalação do Sudo #
######################
su root
apt update -y
apt install sudo -y
echo "userlinux ALL=(ALL:ALL) ALL" >> /etc/sudoers
exit

######################
# Instalação do AIED #
######################
wget -O /tmp/install.py http://www.aied.com.br/linux/download/install_v2.py
sudo apt install libjsoncpp-dev -y
sudo python3 /tmp/install.py

##########################
# Validação 0000 do AIED #
##########################

echo "Teste de ambiente"
sudo aied validar 0000 ola > TesteAIED.txt

#################################
# Validação Prática 98a917ce 01 #
#################################

echo "3.6.1 Criando o ambiente da aula"
sudo aied validar 98a917ce checkpoint01 > 98a917ce01.txt


