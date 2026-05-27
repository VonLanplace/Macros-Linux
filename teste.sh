#!/usr/bin/env bash

# 1. Mostra as interfaces disponíveis e captura o input do usuário
ip a
echo ""
read -p "Digite o nome da interface ativa (ex: enp1s0): " interface

echo "Configurando a interface $interface..."

# 2. Levanta a placa fisicamente usando o ip link set
sudo ip link set $interface up
sudo ip addr flush dev $interface

# 3. Adiciona o IP e a Máscara (24 bits = /24) dinamicamente
sudo ip addr add 10.0.2.3/24 dev $interface

# 4. Adiciona a rota padrão (Gateway)
sudo ip route add default via 10.0.2.2 dev $interface

# 5. Configura o DNS local provisório
sudo sh -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'

# 6. Salva as configurações no arquivo de forma definitiva (para o validador ler)
sudo cp /etc/network/interfaces $(pwd)
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

# 7. Executa a validação do seu checkpoint
sudo aied validar 0002 checkpoint03
