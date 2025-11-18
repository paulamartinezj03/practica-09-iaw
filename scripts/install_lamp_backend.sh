#!/bin/bash
set -ex
#Actualizamos los repositorios
apt update
#Importamos variables
source .env
#Actualizamos los paquetes del sistema
apt upgrade -y
#Instalación de mysql server
sudo apt install mysql-server -y
#Modificamos el parametro bind-address
sed -i "s/127.0.0.1/$MYSQL_SERVER_PRIVATE_IP/" /etc/mysql/mysql.conf.d/mysqld.cnf
#Reiniciamos el servicio de mysql
systemctl restart mysql