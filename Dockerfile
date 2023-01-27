FROM debian:buster

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y nginx
RUN apt-get install -y openssl
RUN apt-get -y install php php-fpm php-mysql
RUN apt-get -y install php-curl
RUN apt-get -y install php-intl
RUN apt-get -y install php-soap
RUN apt-get -y install php-xml php-xmlrpc
RUN apt-get -y install mariadb-server wget

COPY ./srcs/*.sh ./
COPY ./srcs/nginx-conf /etc/nginx/sites-available
COPY ./srcs/off-conf /etc/nginx/sites-available
RUN ln -s /etc/nginx/sites-available/nginx-conf /etc/nginx/sites-enabled/
RUN rm /etc/nginx/sites-enabled/default

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz && \
    tar -xzvf phpMyAdmin-5.0.2-english.tar.gz && \
	mv phpMyAdmin-5.0.2-english/ /var/www/html/phpmyadmin && \
    rm -rf phpMyAdmin-5.0.2-english.tar.gz
COPY ./srcs/phpmyadmin.inc.php /var/www/html/phpmyadmin

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    mv wordpress /var/www/html/ && \
    rm -rf latest.tar.gz
COPY srcs/wp-config.php /var/www/html/wordpress

RUN openssl req -x509 -nodes -newkey rsa:4096 -days 365 -keyout /etc/ssl/private/gbump.key -out /etc/ssl/certs/gbump.crt -subj "/C=RU/ST=Moscow/L=Moscow/O=42 School/OU=gbump/CN=cert"

EXPOSE 80 443

RUN chown -R www-data /var/www/*
RUN chmod -R 755 /var/www/*
RUN chmod +x autoindex_off.sh
RUN chmod +x autoindex_on.sh

CMD bash start.sh
