#!/bin/bash
set -ex
#Actualizamos los repositorios
apt update
#Actualizamos los paquetes del sistema
apt upgrade -y
#Instalación de mysql server
sudo apt install mysql-server -y