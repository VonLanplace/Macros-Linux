########################################################################
# 9.13.3
########################################################################
mkdir -p ~/pacotes/aluno_0_0_amd64/{DEBIAN, usr/bin/}

read -p "Digite o seu identificador de aluno (ou aperte Enter para o padrão): " input_aluno

ALUNO_ID=${input_aluno:-XXXXXXX}

echo "Valor definido: $ALUNO_ID"

tee ~/aluno.c << EOF
#include <stdio.h>

int main() {
    printf("sou o aluno $ALUNO_RA\n");
    return 0;
}
EOF

gcc ~/aluno.c -o ~/pacotes/aluno_0_0_amd64/usr/bin/aluno

tee ~/pacotes/aluno_0_0_amd64/DEBIAN/control << EOF
Package: Aluno
Version: 0.0
Architecture: all
Essential: no
Priority: optional
Maintainer: Aied
Description: Pratica do aluno
EOF

tee ~/pacotes/aluno_0_0_amd64/DEBIAN/preinst << EOF
#!/usr/env/bin bash

if [ -f "/usr/bin/hello" ]; then
	sudo rm -f /usr/bin/hello
	echo "removido"
fi
EOF

chmod 775 ~/pacotes/aluno_0_0_amd64/DEBIAN/preinst

cd ~/pacotes/
dpkg-deb --build aluno_0_0_amd64/
sudo dpkg -i aluno_0_0_amd64.deb
cd ~/Macros-Linux

sudo aied validar 092900 checkpoint02

sudo dpkg -r hello











