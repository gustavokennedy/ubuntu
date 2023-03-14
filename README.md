# Setup inicial para Ubuntu 20.04
Repositório com arquivos, configuração e deploy inicial para Ubuntu 20.04. Usado para aplicações web (php, laravel, javascript, nodejs, mysql, postgres, python...)

### Ferramentas e Tecnologias

 - [NodeJS v16.19.1](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-20-04)
 - [MySQL 8.0.32](https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-ubuntu-20-04)
 - [Nginx 1.18.0](https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-ubuntu-20-04)
 - [Python 3.9](https://linuxize.com/post/how-to-install-python-3-9-on-ubuntu-20-04/)
 - Linux Ubuntu 20.04.2
 - Git 2.25.1

### Iniciando

Clone o repositório:

    git clone git@github.com:gustavokennedy/ubuntu.git

Abra o diretório:

    cd ubuntu

Define permissões para o setup:

    chmod +x setup.sh

Inicie o setup:

    ./setup.sh

Comando em única linha:

    git clone git@github.com:gustavokennedy/ubuntu.git && cd ubuntu && chmod +x setup.sh && ./setup.sh
