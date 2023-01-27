#!/bin/bash
rm /etc/nginx/sites-enabled/off-conf
ln -s /etc/nginx/sites-available/nginx-conf /etc/nginx/sites-enabled/
service nginx restart
bash
