#!/bin/bash
# Para atualizar o Frontend o utilize: ./setup.sh
# Para problemas de permissão: chmod +x setup.sh
set -euo pipefail

echo "
   ______      ________ _____            _      _        _____ _      ____  _    _ _____  
  / __ \ \    / /  ____|  __ \     /\   | |    | |      / ____| |    / __ \| |  | |  __ \ 
 | |  | \ \  / /| |__  | |__) |   /  \  | |    | |     | |    | |   | |  | | |  | | |  | |
 | |  | |\ \/ / |  __| |  _  /   / /\ \ | |    | |     | |    | |   | |  | | |  | | |  | |
 | |__| | \  /  | |____| | \ \  / ____ \| |____| |____ | |____| |___| |__| | |__| | |__| |
  \____/   \/   |______|_|  \_\/_/    \_\______|______(_)_____|______\____/ \____/|_____/ 
                                                                                          
                                                                                          

"
echo "###### Iniciando ambiente ######"
export DEBIAN_FRONTEND=noninteractive
echo "Instalando Ansible..."
# Instala Ansible
sudo apt-add-repository ppa:ansible/ansible --yes
sudo apt update -qy
sudo apt install ansible -qy
echo "---- Ansible instalado com sucesso!"
echo "Configurando playbook do Ansible"
ansible-playbook playbook.yml
