#!/bin/bash
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

# Adicione o usuário sudo e conceda privilégios
useradd --create-home --shell "/bin/bash" --groups sudo "${USERNAME}"

# Verifique se a conta root tem uma senha real definida
encrypted_root_pw="$(grep root /etc/shadow | cut --delimiter=: --fields=2)"

if [ "${encrypted_root_pw}" != "*" ]; then
     # Transfira a senha root gerada automaticamente para o usuário, se presente
     # e bloqueie a conta root para acesso baseado em senha
    echo "${USERNAME}:${encrypted_root_pw}" | chpasswd --encrypted
    passwd --lock root
else
     # Exclua a senha inválida do usuário se estiver usando chaves para que uma nova senha
     # pode ser definido sem fornecer um valor anterior
    passwd --delete "${USERNAME}"
fi

# Expire a senha do usuário sudo imediatamente para forçar uma mudança
chage --lastday 0 "${USERNAME}"

# Cria o diretório SSH para o usuário sudo
home_directory="$(eval echo ~${USERNAME})"
mkdir --parents "${home_directory}/.ssh"

# Copie o arquivo `authorized_keys` da raiz, se solicitado
if [ "${COPY_AUTHORIZED_KEYS_FROM_ROOT}" = true ]; then
    cp /root/.ssh/authorized_keys "${home_directory}/.ssh"
fi

# Adicionar chaves públicas adicionais fornecidas
for pub_key in "${OTHER_PUBLIC_KEYS_TO_ADD[@]}"; do
    echo "${pub_key}" >> "${home_directory}/.ssh/authorized_keys"
done

# Ajuste a propriedade e as permissões da configuração SSH
chmod 0700 "${home_directory}/.ssh"
chmod 0600 "${home_directory}/.ssh/authorized_keys"
chown --recursive "${USERNAME}":"${USERNAME}" "${home_directory}/.ssh"

# Desabilita o login root SSH com senha
sed --in-place 's/^PermitRootLogin.*/PermitRootLogin prohibit-password/g' /etc/ssh/sshd_config
if sshd -t -q; then
    systemctl restart sshd
fi

# Instala Ansible
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible

# Instala Nginx
sudo apt update
sudo apt install nginx

# Instala MySQL
sudo apt install mysql-server

# Instala PHP
sudo apt install php-fpm php-mysql
sudo systemctl reload nginx

# Instala NodeJS
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source ~/.bashrc
nvm install lts/*
nvm use lts/*
sudo apt install npm
