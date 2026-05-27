#
# 9.13.1
#
clear
sudo cp /etc/network/interfaces $(pwd)
sudo cp /etc/resolv.conf $(pwd)
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
sudo aied validar 0002 checkpoint03 | tee ~/9.13.1.txt
wait

sudo cp $(pwd)/interfaces /etc/network/
sudo cp $(pwd)/resolv.conf /etc/
sudo systemctl restart networking

########################################################################
# 9.13.2
########################################################################
########################################################################
# 9.13.2
########################################################################
clear

# 1. Faz o backup dos arquivos originais
sudo cp /etc/network/interfaces $(pwd)
sudo cp /etc/resolv.conf $(pwd)

echo "Configurando o arquivo interfaces para DHCP..."

# 2. Salva no arquivo definitivo como AUTO DHCP (Requisito do exercício)
sudo tee /etc/network/interfaces << EOF
source /etc/network/interfaces.d/*

# Interface Loopback
auto lo
iface lo inet loopback

# Interface configurada como DHCP
auto $interface
iface $interface inet dhcp
EOF

# 3. Reinicia o serviço de rede para aplicar o DHCP do arquivo
sudo systemctl restart networking

# 4. Levanta a placa fisicamente e limpa IPs antigos do DHCP
sudo ip link set $interface up
sudo ip addr flush dev $interface

# 5. Configura por comando IP: Endereço, Máscara e Broadcast
sudo ip addr add 10.0.2.3/24 broadcast 10.0.2.255 dev $interface

# 6. Configura por comando IP: Gateway
sudo ip route add default via 10.0.2.2 dev $interface

sudo sh -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'

echo "Executando a validação do checkpoint..."
echo ""

sudo aied validar 0002 checkpoint04 | tee ~/9.13.2.txt

wait

sudo cp $(pwd)/interfaces /etc/network/interfaces
sudo cp $(pwd)/resolv.conf /etc/resolv.conf
sudo systemctl restart networking

