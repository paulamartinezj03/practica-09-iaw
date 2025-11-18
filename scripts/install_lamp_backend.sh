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
  #Creamos una base de datos de ejemplo
mysql -u root -e "DROP DATABASE IF EXISTS $DB_NAME"
mysql -u root -e "CREATE DATABASE $DB_NAME";

#Creamos un usuario y contraseña para la base de datos
mysql -u root -e "DROP USER IF EXISTS '$DB_USER'@'$IP_CLIENTE_MYSQL';";
mysql -u root -e "CREATE USER $DB_USER@'$IP_CLIENTE_MYSQL' IDENTIFIED BY '$DB_PASSWORD'";
#Le asignamos privilegios de nuestra base de datos
mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO $DB_USER@'$IP_CLIENTE_MYSQL'";