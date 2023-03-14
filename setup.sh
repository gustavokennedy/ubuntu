#!/bin/bash
# Para atualizar o Frontend o utilize: ./setup.sh
# Para problemas de permissão: chmod +x setup.sh
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
echo "${RED} Instalando Ansible...${RESET}"
# Instala Ansible
sudo apt-add-repository ppa:ansible/ansible --yes
sudo apt update -qy
sudo apt install ansible -qy
echo "${GREEN}----OK ANSIBLE INSTALADO COM SUCESSO!${RESET}"
echo "${RESET}Instalando módulos necessários..${RESET}."
sudo apt install php-common php-mysql php-cgi php-mbstring php-curl php-gd php-xml php-xmlrpc php-pear --yes
echo "${GREEN}----OK MÓDULOS INSTALADOS COM SUCESSO!${RESET}"
echo "${RED}Configurando playbook do Ansible...${RESET}"
ansible-playbook playbook.yml
echo "${GREEN}----OK PLAYBOOK FINALIZADO COM SUCESSO!${RESET}"
