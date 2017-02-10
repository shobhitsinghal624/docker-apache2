# Base image
FROM ubuntu:latest
MAINTAINER Shobhit Singhal <shobhitsinghal624@gmail.com>

# Install required packages
RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get update -qq && \
    apt-get install -yqq apache2 libapache2-mod-php php php-mysqli php-gd php-curl curl javascript-common && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Enable mods in apache2
RUN a2enmod rewrite expires headers ext_filter

# Environment variables from /etc/init.d/apache2
ENV APACHE_CONFDIR /etc/apache2
ENV APACHE_ENVVARS $APACHE_CONFDIR/envvars
# Environment variables from /etc/apache2/envvars
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_PID_FILE $APACHE_RUN_DIR/apache2.pid
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV LANG C

# Create relevant directories
RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR

# Expose relevant ports
EXPOSE 80

CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]
