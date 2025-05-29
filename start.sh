#!/bin/bash

mkdir -p /usr/local/nagios/var/rw
chmod 777 /usr/local/nagios/var/rw


# Iniciar Apache
service apache2 start

# Iniciar Nagios
/usr/local/nagios/bin/nagios /usr/local/nagios/etc/nagios.cfg

# Mantener el contenedor activo
tail -f /usr/local/nagios/var/nagios.log

