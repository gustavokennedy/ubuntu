# Setup inicial LEMP para Ubuntu 20.04
Repositório com arquivos, configuração e deploy inicial LEMP para Ubuntu 20.04. Usado para aplicações web (php, laravel, javascript, nodejs, mysql, postgres, python...)

### Ferramentas e Tecnologias

 - [NodeJS v16.19.1](https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-20-04)
 - [MySQL 8.0.32](https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-ubuntu-20-04)
 - [Nginx 1.18.0 e Let's Encrypt](https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mysql-php-lemp-stack-on-ubuntu-20-04)
 - [Python 3.9](https://linuxize.com/post/how-to-install-python-3-9-on-ubuntu-20-04/)
 - Linux Ubuntu 20.04.2
 - Git 2.25.1

## Variáveis

- `dominio`: endereço do domínio.
- `letsencrypt_email`: e-mail para Certificado SSL.
- `http_port`: porta HTTP, default is 80.
- `porta_api`: porta da API, default is 3333.
- `porta_front`: porta do Frontend, default is 3000.
- `db_nome`: nome para criação do banco de dados.

## Rodando Playbook

Passos:

### 1. Baixe o repositório
```shell
git clone https://github.com/gustavokennedy/ubuntu.git
cd ubuntu
```

### 2. Altere as variáveis

```shell
nano vars/default.yml
```

```yml
#vars/default.yml
---
dominio: "domain"
letsencrypt_email: "email_for_le"
http_port: "80"

#API
porta_api: "3333"

#Frontend
porta_front: "3000"

#Banco de Dados
db_nome: "teste"
```

### 3. Rode o Playbook

```shell
chmod +x setup.sh && ./setup.sh
```

##### Se precisar rodar Playbook manualmente

```shell
ansible-playbook playbook.yml
```

