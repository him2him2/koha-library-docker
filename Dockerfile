from ubuntu:20.04

RUN  apt update
RUN  apt upgrade -y
RUN  apt install -y wget sudo wget gnupg2 mariadb-server 
RUN DEBIAN_FRONTEND=noninteractive TZ=America/New_York apt-get -y install tzdata

RUN  wget -qO - https://debian.koha-community.org/koha/gpg.asc | gpg --dearmor -o /usr/share/keyrings/koha-keyring.gpg

RUN  echo deb [signed-by=/usr/share/keyrings/koha-keyring.gpg] https://debian.koha-community.org/koha stable main |  tee /etc/apt/sources.list.d/koha.list
RUN  apt update
RUN  apt upgrade -y
RUN  apt install -y koha-common
RUN  apt install -y apache2
RUN  apt clean
RUN  a2enmod rewrite 
RUN  a2enmod cgi 
RUN  service apache2 restart 

RUN cat /etc/apache2/ports.conf

#RUN echo 'Listen 80' /etc/apache2/ports.conf

RUN koha-create --create-db homeLib
RUN a2enmod headers proxy_http 
RUN koha-plack --enable homeLib
RUN koha-plack --start homeLib
RUN service apache2 restart


 
