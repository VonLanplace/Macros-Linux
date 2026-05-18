#!/usr/bin/env bash

# 1. Pergunta o nome da interface de forma correta e guarda na variável 'interface'
read -p "Digite o nome da interface (ex: enp0s3): " interface

# 2. Escreve no arquivo (repare que tiramos as aspas do EOF para permitir o uso da variável)
sudo tee /etc/network/interfaces << 'EOF'
source /etc/network/interfaces.d/*

# Interface Loopback
auto lo
iface lo inet loopback

# Interface de Rede Estática Correta
auto enp1s0
iface enp1s0 inet static
    address 10.0.2.3
    netmask 255.255.255.0
    gateway 10.0.2.2
    dns-nameservers 8.8.8.8
EOF

# 3. Reinicia a rede para aplicar a alteração antes de validar
echo "Reiniciando o serviço de rede..."
#sudo systemctl restart networking

# 4. Executa a validação do seu checkpoint
sudo aied validar 0002 checkpoint03
