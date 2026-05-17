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

#############################
# Validação inicial do AIED #
#############################

echo "Teste de ambiente"
rm TesteAIED.txt || echo ""
sudo aied validar 0000 ola | tee TesteAIED.txt

############################################
# Prática 3.6.1 Criando o ambiente da aula #
############################################

echo "3.6.1 Criando o ambiente da aula"
rm 3.6.1.txt || echo ""
sudo aied validar 98a917ce checkpoint01 | tee 3.6.1.txt

###
# Prática 4.15.1
##

echo "4.15.1 Criando Diretórios e arquivos no GNU/Linux"
rm 4.15.1.txt || echo ""
rm -r ./diretorio*
mkdir diretorio1 diretorio2 diretorio 3
echo "111" > ./diretorio1/arquivo1
echo "222" > ./diretorio1/arquivo2
echo "333" > ./diretorio1/arquivo3
echo "444" > ./diretorio2/arquivo4
echo "555" > ./diretorio2/arquivo5
echo "666" > ./diretorio2/arquivo6

sudo aied validate 8e9c361c checkpoint01 | tee 4.15.1.txt











