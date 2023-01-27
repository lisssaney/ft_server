#!/bin/bash

service mysql start
mysql -e "create database ft_server;"
mysql -e "create user 'gbump'@'localhost' identified by 'gbump1';"
mysql -e "grant all on ft_server.* to 'gbump'@'localhost';"
mysql -e "flush privileges;"

service php7.3-fpm start
service nginx start

bash
