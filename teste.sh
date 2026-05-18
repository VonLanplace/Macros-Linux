#!/usr/bin/env bash
echo "finalizar 6.15.1"
exit 1
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


