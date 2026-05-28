# 🚀 Guia de Configuração e Automação — Laboratório Linux (Fatec ZL)

![Debian](https://img.shields.io/badge/Debian-D70A30?style=for-the-badge&logo=debian&logoColor=white)
![Bash](https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)
![VirtualBox](https://img.shields.io/badge/VirtualBox-183A61?style=for-the-badge&logo=virtualbox&logoColor=white)
![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

Este repositório contém os scripts de automação e validação de atividades desenvolvidos para o ambiente **Debian 12** na **Faculdade de Tecnologia Zona Leste (Fatec ZL)**. O objetivo é configurar o ambiente da Máquina Virtual (VM) de forma rápida e executar os testes necessários para a geração do relatório final de atividades em formato PDF.

---

## 💻 1. Configurações Fora da VM (VirtualBox)

Antes de iniciar o sistema operacional, certifique-se de aplicar as seguintes configurações na sua máquina virtual através da interface do VirtualBox:

1. **Instalação Inicial**: Realize a instalação padrão do **Debian 12**.
2. **Configuração de Rede (Modo Bridge)**:
   - Abra as **Configurações** da VM no VirtualBox.
   - Navegue até a aba **Rede** > Habilite o **Adaptador 1**.
   - No campo **"Conectado a"**, altere a opção para **Placa em modo Bridge** (*Adaptador Ponte*) e clique em **OK**.
3. **Armazenamento de Dados**:
   - Vá em **Armazenamento** > Habilite o controlador correspondente.
   - Crie um novo **Disco Rígido Virtual de 1GB** e conecte-o à VM.
4. **Mídia Complementar (ISO)**:
   - Baixe a [ISO do AIED no Google Drive](https://drive.google.com/file/d/1xk-6ZDSbB8d6JZzSqy7NjUyM6p3xBLHU/view?usp=sharing).
   - Conecte o arquivo ISO baixado no drive de CD/DVD virtual da sua VM.

---

## 🐧 2. Ações Dentro da VM

Após inicializar a VM e realizar o login com as suas credenciais, abra o terminal e execute os passos abaixo.

### 🔌 Passo 2.1: Preparação do Ambiente e Clone do Repositório

Torne-se superusuário (`root`), instale o Git e clone este repositório para a sua máquina:

```bash
# Alterar para o usuário root (será solicitada a senha do root definida na instalação)
su root

# Atualizar a lista de pacotes e instalar o git
apt update && apt install git -y

# Clonar o repositório oficial de macros
git clone [https://github.com/VonLanplace/Macros-Linux.git](https://github.com/VonLanplace/Macros-Linux.git)

```

> 💡 **Dica de Produtividade (Acesso via SSH):** Após a execução do script de instalação do `sudo` (no próximo passo), você poderá se conectar à VM diretamente pelo terminal do seu sistema hospedeiro (Windows/Mac/Linux). Para descobrir o endereço IP da máquina virtual, execute o comando `ip a`. O comando para conexão externa será: `ssh seu_usuario@IP_DA_VM`.

### ⚡ Passo 2.2: Execução dos Scripts de Automação

Navegue até a pasta do repositório clonado e execute os scripts em ordem para validar as atividades:

```bash
# Entrar no diretório do projeto, dar permissão e instalar o Sudo
cd Macros-Linux
chmod +x *.sh
./installSudo.sh

# Executar a automação e validação principal
./auto.sh

```

⚠️ **Atenção:** O sistema fará algumas pausas controladas para solicitar dados e interações do usuário. Fique atento ao terminal: **as recomendações de respostas esperadas estarão listadas entre parênteses `()**`.

---

## 📄 3. Coleta do Relatório (Extraindo o PDF)

Após a conclusão com sucesso de todos os scripts, um arquivo consolidado chamado `ATIVIDADES.pdf` será gerado automaticamente no diretório *home* do seu usuário Linux (`~`).

Para transferir o relatório da VM para a sua máquina física (Windows), abra o **Prompt de Comando (CMD)** ou **PowerShell** no Windows e execute o comando `scp` substituindo os campos necessários:

```cmd
scp seu_usuario_linux@IP_DA_SUA_VM:~/ATIVIDADES.pdf %USERPROFILE%\Downloads

```

O arquivo final estará disponível imediatamente na sua pasta de **Downloads** do Windows.

---