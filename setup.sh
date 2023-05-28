#!/bin/bash
# Para atualizar o Frontend o utilize: ./setup.sh
# Para problemas de permissão: chmod +x setup.sh
# Gustavo Kennedy Renkel
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 4`
WHITE=`tput setaf 7`
BOLD=`tput bold`
RESET=`tput sgr0`

set -euo pipefail

echo "${GREEN}
   ______      ________ _____            _      _        _____ _      ____  _    _ _____  
  / __ \ \    / /  ____|  __ \     /\   | |    | |      / ____| |    / __ \| |  | |  __ \ 
 | |  | \ \  / /| |__  | |__) |   /  \  | |    | |     | |    | |   | |  | | |  | | |  | |
 | |  | |\ \/ / |  __| |  _  /   / /\ \ | |    | |     | |    | |   | |  | | |  | | |  | |
 | |__| | \  /  | |____| | \ \  / ____ \| |____| |____ | |____| |___| |__| | |__| | |__| |
  \____/   \/   |______|_|  \_\/_/    \_\______|______(_)_____|______\____/ \____/|_____/ 
                                                                                          
                                                                                          

"
echo -e "${YELLOW} INICIANDO AMBIENTE ${RESET}"
export DEBIAN_FRONTEND=noninteractive
echo "${RED} Atualizando sistema...${RESET}"
sudo apt update --yes && sudo apt list --upgradable --yes && sudo apt upgrade --yes
echo "${GREEN}----OK SISTEMA ATUALIZADO COM SUCESSO!${RESET}"
echo "${RED} Limpando cache do sistema...${RESET}"
sudo apt autoremove --yes && sudo apt autoclean --yes && sudo apt clean --yes
echo "${GREEN}----OK CACHE LIMPO COM SUCESSO!${RESET}"
echo "${RED} Configurando timezone do servidor...${RESET}"
sudo timedatectl set-timezone "America/Sao_Paulo"
sudo systemctl restart systemd-timesyncd.service
echo "${GREEN}----OK TIMEZONE ATUALIZADO COM SUCESSO!${RESET}"
echo "${RED} Instalando Ansible...${RESET}"
# Instala Ansible
sudo apt-add-repository ppa:ansible/ansible --yes
sudo apt update -qy
sudo apt install ansible -qy
echo "${GREEN}----OK ANSIBLE INSTALADO COM SUCESSO!${RESET}"
echo "${RED} Instalando módulos necessários..${RESET}."
sudo apt install php-common php-mysql php-cgi php-mbstring php-curl php-gd php-xml php-xmlrpc php-pear --yes
echo "${GREEN}----OK MÓDULOS INSTALADOS COM SUCESSO!${RESET}"
echo "${RED} Configurando playbook do Ansible...${RESET}"
echo "..."
ansible-playbook playbook.yml
echo "..."
echo "${GREEN}----OK PLAYBOOK FINALIZADO COM SUCESSO!${RESET}"
echo "${RED}  Instalando NVM & NodeJS...${RESET}"
sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh
sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
nvm install node
echo "${GREEN}----OK NVM E NODEJS INSTALADOS COM SUCESSO!${RESET}"
#echo "${RED}  Instalando PHPMYADMIN...${RESET}"
#sudo apt install phpmyadmin php-mbstring php-zip php-gd php-json php-curl -qy --yes
#echo "${GREEN}----OK PHPMYADMIN INSTALADO COM SUCESSO!${RESET}"
#echo "${RED}  Reiniciando Nginx...${RESET}"
sudo systemctl reload nginx && sudo systemctl restart nginx
#echo "${GREEN}----OK NGINX REINICIADO COM SUCESSO!${RESET}"
# Instalando ZSH
#echo "${RED}  Instalando ZSH e NVIM...${RESET}"
sudo apt install zsh neovim --yes
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" -h
#echo "${GREEN}----OK ZSH e NVIM INSTALADOS COM SUCESSO!${RESET}"
