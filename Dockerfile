FROM debian:bullseye

LABEL maintainer="tu_email@dominio.com"
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias
RUN apt-get update && apt-get install -y \
    autoconf \
    build-essential \
    wget \
    unzip \
    apache2 \
    php \
    libapache2-mod-php \
    libgd-dev \
    libmcrypt-dev \
    libssl-dev \
    daemon \
    curl \
    libjpeg-dev \
    libpng-dev \
    libperl-dev \
    libdbi-dev \
    libmariadb-dev-compat \
    libmariadb-dev \
    snmp \
    libnet-snmp-perl \
    gettext-base \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Crear usuario nagios
RUN useradd nagios && groupadd nagcmd && usermod -a -G nagcmd nagios && usermod -a -G nagcmd www-data

# Descargar Nagios Core
WORKDIR /tmp
RUN wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.14.tar.gz && \
    tar -zxvf nagios-4.4.14.tar.gz && \
    cd nagios-4.4.14 && \
    ./configure --with-command-group=nagcmd && \
    make all && \
    make install && \
    make install-init && \
    make install-commandmode && \
    make install-config && \
    make install-webconf

# Crear usuario y contraseña para Nagios Web UI
RUN htpasswd -b -c /usr/local/nagios/etc/htpasswd.users nagiosadmin nagiosadmin

# Habilitar Apache y CGI
RUN a2enmod cgi && a2enmod rewrite

# Iniciar servicios al arrancar el contenedor
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Exponer el puerto 80
EXPOSE 80

CMD ["/start.sh"]

