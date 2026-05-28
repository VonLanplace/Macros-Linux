#!/usr/bin/env bash
######################
# 11.6.1
######################

read -p "Digite seu nome: " NOME_ALUNO
NOME_ALUNO="${NOME_ALUNO:-AlunoAIED}"

tee ~/atividadei.sh << EOF
#!/bin/bash
printf "%s\n" "$NOME_ALUNO"
EOF

chmod +x ~/atividadei.sh

sudo aied validar 8ab001 checkpoint01

######################
# 11.6.2
######################

tee ~/atividadeii.sh << 'EOF'
#!/bin/bash
# Como precisamos do nome do aluno aqui dentro, vamos ler do script anterior ou deixar fixo
# Se o validador testar com o arquivo estático, precisamos gerar com o nome real.
# Para misturar variáveis locais e externas, usamos a barra invertida \ antes do $ local:
EOF

tee ~/atividadeii.sh << EOF
#!/bin/bash
declare x="$NOME_ALUNO"
printf "%s\n" "\$x"
EOF

chmod +x ~/atividadeii.sh

sudo aied validar 8ab001 checkpoint02

######################
# 11.6.3
######################

tee ~/atividadeiii.py << EOF
#!/usr/bin/env python3
print("$NOME_ALUNO")
EOF

chmod +x ~/atividadeiii.py

sudo aied validar 8ab001 checkpoint03

######################
# 11.6.4
######################

tee ~/atividadeiv.sh << 'EOF'
#!/bin/bash
NUM=$1
if (( NUM % 2 == 0 )); then
  printf "par"
else
  printf "impar"
fi
EOF

chmod +x ~/atividadeiv.sh

sudo aied validar 8ab001 checkpoint04

######################
# 11.6.5
######################

tee ~/atividadev.sh << 'EOF'
#!/bin/bash
NUM=$1
if [ "$NUM" -gt 2 ]; then
  printf "maior"
else
  printf "menor ou igual"
fi
EOF

chmod +x ~/atividadev.sh

sudo aied validar 8ab001 checkpoint05
