from ubuntu:20.04

RUN wget -O- https://debian.koha-community.org/koha/gpg.asc | sudo apt-key add -
RUN echo deb http://debian.koha-community.org/koha stable main | sudo tee /etc/apt/sources.list.d/koha.list
RUN  apt update
RUN  apt upgrade
RUN  apt install koha-common
RUN  apt install apache2
RUN  apt clean
RUN  a2enmod rewrite 
RUN  a2enmod cgi 
RUN  systemctl restart apache2.service

 
