#!/usr/bin/env bash
##########
# 14.4.1 #
##########
sudo apt install at -y

echo "touch /tmp/teste.txt" | at 12:00
wait

sudo aied validar 4d4f6ae checkpoint01
##########
# 14.4.2 #
##########

tee ~/script.sh << 'EOF'
#!/bin/bash
#nome: script.sh
#diretório: ~/
#descrição: Faz o backup do diretorio do usuário, é apenas um exemplo de aula

data=$(/bin/date +%d-%m-%Y);

#atenção, vou guardar em /tmp para
tar -cvzf /tmp/backup-${LOGNAME}-${data}.tar.gz /home/${LOGNAME}/;
EOF

chmod +x ~/script.sh

(crontab -l 2>/dev/null; echo "* 12 * * * /bin/bash ~/script.sh") | crontab -
wait

sudo aied validar d7a527b checkpoint01
