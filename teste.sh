#!/usr/bin/env bash
######################
# 12.6.1
######################
sudo apt update -y
sudo apt install python3-pip -y

wait
python3 -m pip install network --break-system-packages 2>/dev/null || python3 -m pip install network

wait
sudo aied validar py0001 checkpoint01 | tee ~/12.6.1

######################
# 12.6.2
######################

tee ~/pythonscript1.py << 'EOF'
#!/usr/bin/python3
import os
print(os.getenv("LOGNAME"))
EOF
chmod +x ~/pythonscript1.py
wait

sudo aied validar py0001 checkpoint02 | tee ~/12.6.2

######################
# 12.6.3
######################

tee ~/pythonscript2.py << 'EOF'
#!/usr/bin/python3
import hashlib
import sys

if len(sys.argv) < 2:
    argumento = "Aied"
else:
    argumento = sys.argv[1]

MD5 = hashlib.md5(argumento.encode('utf-8')).hexdigest()

print(MD5)
EOF
chmod +x ~/pythonscript2.py
wait

sudo aied validar py0001 checkpoint03 | tee ~/12.6.3

######################
# 12.6.4
######################

mkdir -p /home/userlinux

tee /home/userlinux/pythonscript3.py << 'EOF'
#!/usr/bin/python3

with open("/etc/passwd", "r") as arquivo:
    linhas = arquivo.readlines()

for linha in linhas:
    dados = linha.strip().split(':')
    
    if len(dados) >= 7:
        usuario = dados[0]
        shell = dados[6]
        
        if shell == "/bin/bash":
            print(usuario)
EOF

chmod +x /home/userlinux/pythonscript3.py
wait

sudo aied validar py0001 checkpoint04 | tee ~/12.6.4

######################
# 12.6.5
######################

tee /home/userlinux/pythonscript4.py << 'EOF'
#!/usr/bin/python3
import sys
import os

if len(sys.argv) < 2:
    valor = "Aied\n"
else:
    valor = sys.argv[1] + "\n"

fd = os.open("/tmp/argumento.txt", os.O_RDWR | os.O_CREAT | os.O_TRUNC, 0o644)
os.write(fd, valor.encode())
os.close(fd)
EOF

chmod +x /home/userlinux/pythonscript4.py
wait

sudo aied validar py0001 checkpoint05 | tee ~/12.6.5
