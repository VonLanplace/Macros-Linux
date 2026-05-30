# 🚀 Guia de Configuração e Automação — Laboratório Linux (Fatec ZL)

<p align="center">
  <a href="https://www.debian.org/releases/bookworm/">
      <img src="https://img.shields.io/badge/Debian_12-D70A30?style=for-the-badge&logo=debian&logoColor=white" alt="Debian">
  </a>
  <a href="https://www.gnu.org/software/bash/">
      <img src="https://img.shields.io/badge/Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Bash">
  </a>
  <a href="https://www.virtualbox.org/">
      <img src="https://img.shields.io/badge/VirtualBox-183A61?style=for-the-badge&logo=virtualbox&logoColor=white" alt="VirtualBox">
  </a>
  <a href="https://www.kernel.org/">
      <img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black" alt="Linux">
  </a>
</p>

Este repositório contém os scripts de automação e validação de atividades desenvolvidos para o ambiente **Debian 12** na **Faculdade de Tecnologia Zona Leste (Fatec ZL)**. O objetivo é configurar o ambiente da Máquina Virtual (VM) de forma rápida e executar os testes necessários para a geração do relatório final de atividades em formato PDF.

---

## 💻 1. Configurações Fora da VM (VirtualBox)

Antes de iniciar o sistema operacional, certifique-se de aplicar as seguintes configurações na sua máquina virtual através da interface do VirtualBox:

1. **Instalação Inicial**: Realize a instalação padrão do **Debian 12**.
2. **Configuração de Rede (Modo NAT)**:
   - Abra as **Configurações** da VM no VirtualBox.
   - Navegue até a aba **Rede** > Habilite o **Adaptador 1**.
   - No campo **"Conectado a"**, selecione a opção **NAT** e clique em **OK**.
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

> 💡 **Dica de Produtividade (Acesso via SSH em modo NAT):** Como a VM está em modo NAT, para acessá-la do seu sistema hospedeiro (Windows/Mac/Linux), você precisará configurar o **Redirecionamento de Portas** nas configurações avançadas de Rede da VM no VirtualBox (ex: mapear a porta hospedeira `2222` para a porta convidada `22` da VM). Após isso, o comando para conexão externa será: `ssh seu_usuario@localhost -p 2222`.

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

Para transferir o relatório da VM em modo NAT para a sua máquina física (Windows), abra o **Prompt de Comando (CMD)** ou **PowerShell** no Windows e execute o comando `scp` especificando a porta configurada no redirecionamento:

```cmd
scp -P 2222 seu_usuario_linux@localhost:~/ATIVIDADES.pdf %USERPROFILE%\Downloads

```

O arquivo final estará disponível imediatamente na sua pasta de **Downloads** do Windows.


