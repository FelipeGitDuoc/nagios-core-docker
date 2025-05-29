# Nagios Core en Docker

Este repositorio contiene los archivos necesarios para construir y ejecutar una imagen Docker de Nagios Core en una instancia EC2 con Ubuntu.

##  Requisitos

- Docker instalado
- Acceso a una instancia EC2 de Ubuntu
- Puerto 80 abierto en el Security Group

##  Archivos incluidos

- `Dockerfile`: Construye la imagen con Nagios y Apache.
- `start.sh`: Script de arranque para iniciar Apache y Nagios.
- `README.md`: Documentación del proyecto.

##  Construcción de la imagen

```bash
git clone https://github.com/FelipeGitDuoc/nagios-core-docker
cd nagios-core-docker
docker build -t nagios-core .

docker run -d -p 80:80 --name nagios nagios-core
http://[IP_PUBLICA_DE_TU_EC2]/nagios
Usuario: nagiosadmin
Contraseña: nagiosadmin
