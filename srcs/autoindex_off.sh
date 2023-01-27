#!/bin/bash
rm /etc/nginx/sites-enabled/nginx-conf
ln -s /etc/nginx/sites-available/off-conf /etc/nginx/sites-enabled/
service nginx restart
