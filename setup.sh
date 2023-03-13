#!/bin/bash
# Para atualizar o Frontend o utilize: ./setup.sh
# Para problemas de permissão: chmod +x setup.sh
set -euo pipefail

########################
### VIARIAVEIS DE SCRIPT ###
########################

# Nome do usuário para criar e conceder privilégios sudo
USERNAME=overall

# Se deve copiar o arquivo `authorized_keys` do usuário root para o novo sudo
# do utilizador.
COPY_AUTHORIZED_KEYS_FROM_ROOT=true

# Chaves públicas adicionais para adicionar ao novo usuário sudo
# OTHER_PUBLIC_KEYS_TO_ADD=(
#     "ssh-rsa AAAAB..."
#     "ssh-rsa AAAAB..."
# )
OTHER_PUBLIC_KEYS_TO_ADD=(
)

####################
### VARIAVEIS LÓGICAS ###
####################

echo
" _____     _______ ____      _    _     _       ____ _     ___  _   _ ____
 / _ \ \   / / ____|  _ \    / \  | |   | |     / ___| |   / _ \| | | |  _ \
| | | \ \ / /|  _| | |_) |  / _ \ | |   | |    | |   | |  | | | | | | | | | |
| |_| |\ V / | |___|  _ <  / ___ \| |___| |___ | |___| |__| |_| | |_| | |_| |
 \___/  \_/  |_____|_| \_\/_/   \_\_____|_____(_)____|_____\___/ \___/|____/
"

echo "Iniciando ambiente..."
echo "Aidiconando usuário sudo e ajustando privilégios..."
# Adicione o usuário sudo e conceda privilégios
useradd --create-home --shell "/bin/bash" --groups sudo "${USERNAME}"

echo "Verificando se conta possui senha real..."
# Verifique se a conta root tem uma senha real definida
encrypted_root_pw="$(grep root /etc/shadow | cut --delimiter=: --fields=2)"

echo "Criando diretório SSH para usuário sudo..."
# Cria o diretório SSH para o usuário sudo
home_directory="$(eval echo ~${USERNAME})"
mkdir --parents "${home_directory}/.ssh"

echo "Copiando chaves autorizadas SSH..."
# Copie o arquivo `authorized_keys` da raiz, se solicitado
if [ "${COPY_AUTHORIZED_KEYS_FROM_ROOT}" = true ]; then
    cp /root/.ssh/authorized_keys "${home_directory}/.ssh"
fi

echo "Adicioando chaves SSH fornecidas..."
# Adicionar chaves públicas adicionais fornecidas
for pub_key in "${OTHER_PUBLIC_KEYS_TO_ADD[@]}"; do
    echo "${pub_key}" >> "${home_directory}/.ssh/authorized_keys"
done

echo "Ajustando permissões e propriedades do SSH..."
# Ajuste a propriedade e as permissões da configuração SSH
chmod 0700 "${home_directory}/.ssh"
chmod 0600 "${home_directory}/.ssh/authorized_keys"
chown --recursive "${USERNAME}":"${USERNAME}" "${home_directory}/.ssh"

echo "Instalando Ansible..."
# Instala Ansible
sudo apt-add-repository ppa:ansible/ansible
sudo apt update -y
sudo apt install ansible -y
echo "---- Ansible instalado com sucesso!"

echo "Instalando Nginx..."
# Instala Nginx
sudo apt update -y
sudo apt install nginx -y
echo "---- Nginx instalado com sucesso!"

echo "Instalando MySQL..."
# Instala MySQL
sudo apt install mysql-server -y
echo "---- MySQL instalado com sucesso!"

echo "Instalando PHP..."
# Instala PHP
sudo apt install php-fpm php-mysql -y
sudo systemctl reload nginx
echo "---- PHP instalado com sucesso!"

echo "Instalando NodeJS com NVM..."
# Instala NodeJS
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bashrc
nvm install lts/*
nvm use lts/*
sudo apt install npm -y
echo "---- NodeJS & NPM instalados com sucesso!"
