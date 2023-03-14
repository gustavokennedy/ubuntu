#!/bin/bash
# Para atualizar o Frontend o utilize: ./setup.sh
# Para problemas de permissão: chmod +x setup.sh
set -euo pipefail

echo " _____     _______ ____      _    _     _       ____ _     ___  _   _ ____
 / _ \ \   / / ____|  _ \    / \  | |   | |     / ___| |   / _ \| | | |  _ \
| | | \ \ / /|  _| | |_) |  / _ \ | |   | |    | |   | |  | | | | | | | | | |
| |_| |\ V / | |___|  _ <  / ___ \| |___| |___ | |___| |__| |_| | |_| | |_| |
 \___/  \_/  |_____|_| \_\/_/   \_\_____|_____(_)____|_____\___/ \___/|____/
"
echo "###### Iniciando ambiente ######"

echo "Instalando Ansible..."
# Instala Ansible
sudo apt-add-repository ppa:ansible/ansible
sudo apt update -y
sudo apt install ansible -y
echo "---- Ansible instalado com sucesso!"
