#!/usr/bin/env bash
sudo tee /etc/network/interfaces <<'EOF'
source /etc/network/interfaces.d/*
# Interface Loopback
auto lo
iface lo inet loopback

# Interface de Rede Estática (ajuste o eth0 se o seu nome de interface for diferente)
auto eth0

    address 10.0.2.3
    netmask 255.255.255.0
    gateway 10.0.2.2
    dns-nameservers 8.8.8.8
EOF

sudo aied validar 0002 checkpoint03 
