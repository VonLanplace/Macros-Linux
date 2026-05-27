#!/usr/bin/env bash
######################
# Instalação do AIED #
######################
wget -O /tmp/install.py http://www.aied.com.br/linux/download/install_v2.py
sudo apt install libjsoncpp-dev -y
sudo apt install vim -y
sudo python3 /tmp/install.py

#############################
# Validação inicial do AIED #
#############################

echo "Teste de ambiente"
rm ~/TesteAIED.txt || echo ""
sudo aied validar 0000 ola | tee ~/TesteAIED.txt

############################################
# Prática 3.6.1 Criando o ambiente da aula #
############################################

echo "3.6.1 Criando o ambiente da aula"
rm ~/3.6.1.txt || echo ""
sudo aied validar 98a917ce checkpoint01 | tee ~/3.6.1.txt

##################
# Prática 4.15.1 #
##################

echo "4.15.1 Criando Diretórios e arquivos no GNU/Linux"
rm ~/4.15.1.txt || echo ""
rm -r ~/diretorio*
mkdir ~/diretorio{1,2,3}
echo "111" > ~/diretorio1/arquivo1
echo "222" > ~/diretorio1/arquivo2
echo "333" > ~/diretorio1/arquivo3
echo "444" > ~/diretorio2/arquivo4
echo "555" > ~/diretorio2/arquivo5
echo "666" > ~/diretorio2/arquivo6

sudo aied validate 8e9c361c checkpoint01 | tee ~/4.15.1.txt

##################
# Prática 4.15.2 #
##################
echo "4.15.2"
rm ~/4.15.2.txt || echo ""

cp ~/diretorio1/arquivo1 ~/diretorio3/arquivo1
rm ~/diretorio2/arquivo4
mv ~/diretorio2/arquivo5 ~/diretorio3/

sudo aied validate 8e9c361c checkpoint02 | tee ~/4.15.2.txt

##################
# Prática 4.15.3 #
##################
echo "4.15.3"
rm ~/4.15.3.txt || echo ""

ln -s ~/diretorio1/arquivo3 ~/diretorio3/arquivo3
ln ~/diretorio2/arquivo6 ~/diretorio3/arquivo6

sudo aied validate 8e9c361c checkpoint03 | tee ~/4.15.3.txt

##################
# Prática 4.15.4 #
##################
echo "4.15.4"
rm ~/4.15.4.txt || echo ""
rm ~/copiar*
cat <<'EOF' > copiar.cpp
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>

int main(int argc, char *argv[]);
#define BUF_SIZE 4096
#define OUTPUT_MODE 0640

int main(int argc, char *argv[])
{
    int in_fd, out_fd, rd_count, wt_count;
    char buffer[BUF_SIZE];
    if (argc != 3) exit(1);
    in_fd = open(argv[1], O_RDONLY);
    if (in_fd < 0) exit(2);
    out_fd = creat(argv[2], OUTPUT_MODE);
    if (out_fd < 0) exit(3);
    
    while (true) {
        rd_count = read(in_fd, buffer, BUF_SIZE);
        if (rd_count <= 0) break;
        wt_count = write(out_fd, buffer, rd_count);
        if (wt_count <= 0) exit(4);
    }

    close(in_fd);
    close(out_fd);
    
    if ( rd_count == 0)
        exit(0);
    else
        exit(5);
}
EOF
gcc copiar.cpp -o copiar

mkdir ~/{tmp,bin}
chmod +t ~/tmp
cp copiar ~/bin/
chmod 1777 ~/tmp/
chmod 755 ~/bin/copiar
chmod 4755 /etc/aied/aied_64

sudo aied validate 8e9c361c checkpoint04 | tee ~/4.15.4.txt

##########
# 5.15.1 #
##########
echo "5.15.1"
rm ~/5.15.1.txt || echo ""

sudo groupadd alunos
sudo useradd -g alunos joao
sudo useradd leticia
sudo useradd wanderson
sudo mkdir -p /hd2/usuarios/
sudo chmod 755 /hd2/usuarios/
sudo useradd -m -d /hd2/usuarios/bia bia
echo "Insira a senha do wanderson"
sudo passwd wanderson
wait
echo "Insira a senha do bia"
sudo passwd bia
wait
echo "Insira a senha do leticia"
sudo passwd leticia
wait

sudo aied validate fcb0b800 checkpoint01 | tee ~/5.15.1.txt

##########
# 5.15.2 #
##########
sudo usermod -g alunos leticia
sudo usermod -g alunos wanderson
sudo usermod -g alunos bia

sudo usermod -m -d /hd2/usuarios/wanderson wanderson
sudo usermod -m -d /hd2/usuarios/leticia leticia
sudo usermod -m -d /hd2/usuarios/joao joao

sudo usermod -L leticia

sudo usermod -s /bin/false leticia

sudo aied validate fcb0b800 checkpoint02 | tee ~/5.15.2.txt

##########
# 5.15.3 #
##########
sudo usermod -p '*' root
sudo usermod -s /bin/false www-data
sudo aied validate fcb0b800 checkpoint03 | tee ~/5.15.3.txt

##########
# 5.15.4 #
##########
sudo groupadd tomcat

sudo useradd -s /bin/false -g tomcat -d /opt/tomcat -M tomcat
sudo mkdir -p /opt/tomcat
sudo chgrp tomcat /opt/tomcat
sudo aied validate fcb0b800 checkpoint04 | tee ~/5.15.4.txt

##########
# 6.15.1 #
##########

echo "=== DISCOS DISPONÍVEIS NO SISTEMA ==="
lsblk -d -o NAME,SIZE,MODEL | grep -v "loop"
echo "-------------------------------------"

read -p "Digite o nome do disco que deseja formatar (ex: vdb): " DISK_INPUT

DISK_INPUT=$(echo "$DISK_INPUT" | sed 's|^/dev/||')

DISK="/dev/$DISK_INPUT"
PARTITION="${DISK}1"

echo -e "g\nn\n1\n\n\nw" | sudo fdisk $DISK
sudo mkfs.ext4 $PARTITION
sudo mkdir -p /backup
echo "UUID=$(sudo lsblk -no UUID $PARTITION) /backup ext4 defaults,nofail 0 2" | sudo tee -a /etc/fstab
sudo systemctl daemon-reload
sudo mount -a

sudo aied validate 8b65b431 checkpoint01 | tee ~/6.15.1.txt

##########
# 6.15.2 #
##########

mkdir /home/userlinux/cdrom
sudo mount /dev/sr0 /home/userlinux/cdrom/

sudo aied validar 8b65b431 checkpoint02 | tee ~/6.15.2.txt

##########
# 7.14.1 #
##########

ps aux | grep python > ~/typescript
sudo aied validar prc0001 checkpoint01 | tee ~/7.14.1.txt
rm ~/typescript

##########
# 9.13.1 #
##########

sudo cp /etc/network/interfaces $(pwd)
sudo cp /etc/resolv.conf $(pwd)

ip a
echo ""
read -p "Digite o nome da interface ativa (ex: enp0s3): " interface

echo "Configurando a interface $interface..."

sudo ip link set $interface up
sudo ip addr flush dev $interface

sudo ip addr add 10.0.2.3/24 dev $interface

sudo ip route add default via 10.0.2.2 dev $interface

sudo sh -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'

sudo tee /etc/network/interfaces << EOF
source /etc/network/interfaces.d/*

# Interface Loopback
auto lo
iface lo inet loopback

# Interface Estática Dinâmica
auto $interface
iface $interface inet static
    address 10.0.2.3
    netmask 255.255.255.0
    gateway 10.0.2.2
    dns-nameservers 8.8.8.8
    broadcast 10.0.2.255
EOF
sudo systemctl restart networking

echo "Configuração aplicada com sucesso!"
echo "Executando a validação do checkpoint..."
echo ""

sudo aied validar 0002 checkpoint03 | tee ~/9.13.1.txt
wait

sudo cp $(pwd)/interfaces /etc/network/
sudo cp $(pwd)/resolv.conf /etc/
sudo systemctl restart networking

##########
# 9.13.2 #
##########

sudo cp /etc/network/interfaces $(pwd)
sudo cp /etc/resolv.conf $(pwd)

echo "Configurando o arquivo interfaces para DHCP..."

sudo tee /etc/network/interfaces << EOF
source /etc/network/interfaces.d/*

# Interface Loopback
auto lo
iface lo inet loopback

# Interface configurada como DHCP
auto $interface
iface $interface inet dhcp
EOF

sudo systemctl restart networking

sudo ip link set $interface up
sudo ip addr flush dev $interface

sudo ip addr add 10.0.2.3/24 broadcast 10.0.2.255 dev $interface

sudo ip route add default via 10.0.2.2 dev $interface

sudo sh -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'

echo "Executando a validação do checkpoint..."
echo ""

sudo aied validar 0002 checkpoint04 | tee ~/9.13.2.txt

wait

sudo cp $(pwd)/interfaces /etc/network/interfaces
sudo cp $(pwd)/resolv.conf /etc/resolv.conf
sudo systemctl restart networking


##########
# 9.13.3 #
##########

wget -O  /tmp/install.py http://www.aied.com.br/linux/download/install.py

sudo aied validar 0002 checkpoint05 | tee ~/9.13.3.txt
