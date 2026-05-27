########################################################################
# 10.5.2 - Corrigido
########################################################################
mkdir -p ~/pacotes/aluno_0_0_amd64/usr/bin
mkdir -p ~/pacotes/aluno_0_0_amd64/DEBIAN

read -p "Digite o seu identificador de aluno (ou aperte Enter para o padrão): " input_aluno

# Define o ID padrão caso o usuário dê apenas Enter
ALUNO_ID=${input_aluno:-XXXXXXX}

echo "Valor definido: $ALUNO_ID"

# CORREÇÃO: Usando a variável correta ($ALUNO_ID)
tee ~/aluno.c << EOF
#include <stdio.h>

int main() {
    printf("sou o aluno $ALUNO_ID\n");
    return 0;
}
EOF

# Compila o binário direto para a pasta do pacote
gcc ~/aluno.c -o ~/pacotes/aluno_0_0_amd64/usr/bin/aluno

# Cria o arquivo de controle do pacote Debian
tee ~/pacotes/aluno_0_0_amd64/DEBIAN/control << EOF
Package: Aluno
Version: 0.0
Architecture: all
Essential: no
Priority: optional
Maintainer: Aied
Description: Pratica do aluno
EOF

# CORREÇÃO: Ajustado o shebang para /usr/bin/env bash
tee ~/pacotes/aluno_0_0_amd64/DEBIAN/preinst << EOF
#!/usr/bin/env bash
if [ -f "/usr/bin/hello" ]; then
    rm -f /usr/bin/hello
    echo "removido"
fi
EOF

# Dá permissão de execução para o script de pré-instalação
chmod 775 ~/pacotes/aluno_0_0_amd64/DEBIAN/preinst

# Vai para o diretório, constrói e instala o pacote
cd ~/pacotes/
dpkg-deb --build aluno_0_0_amd64/
sudo dpkg -i aluno_0_0_amd64.deb

# Validação do exercício
cd ~/Macros-Linux
sudo aied validar 092900 checkpoint01
wait

######################
# 10.5.2 - Corrigido #
######################
# Limpeza opcional do pacote instalado se necessário
sudo dpkg -r aluno
wait
sudo aied validar 092900 checkpoint02
