#!/usr/bin/env bash
sudo cat <<'EOF' > /etc/network/interfaces
auto lo
iface lo inet loopback
auto eth0
iface eth0 inet static
    address 10.0.2.3
    netmask 255.255.255.0
    gateway 10.0.2.2
    dns-nameservers 8.8.8.8
EOF
sudo aied validar 0002 checkpoint03 
