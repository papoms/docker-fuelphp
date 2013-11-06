FROM ubuntu:latest
MAINTAINER Paul Porzky <paulporzky@gmail.com>

# Update Packages
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update
RUN apt-get upgrade -y

# Install Dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-client mysql-server apache2 libapache2-mod-php5 pwgen python-setuptools vim-tiny php5-mysql git

# Configure Supervisor & startscripts
RUN easy_install supervisor
ADD ./start.sh /start.sh
ADD ./foreground.sh /etc/apache2/foreground.sh
ADD ./supervisord.conf /etc/supervisord.conf
RUN chmod 755 /start.sh
RUN chmod 755 /etc/apache2/foreground.sh

#Install fuel
RUN cd /var/www/ ; git clone --recursive git://github.com/fuel/fuel.git ; cd fuel/ ; php composer.phar self-update ; php composer.phar update ; php oil refine install
ADD ./fuel-vhost /etc/apache2/sites-available/fuel
RUN a2ensite fuel ; a2dissite default ; service apache2 reload

# Setup Port and Start CMD
EXPOSE 80
CMD ["/bin/bash", "/start.sh"]
