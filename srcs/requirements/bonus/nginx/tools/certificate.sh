#!/bin/bash

sed -i "s/my_cert/$ssl_certificate/g" /etc/nginx/sites-available/default
sed -i "s/my_key/$ssl_certificate_key/g" /etc/nginx/sites-available/default
sed -i "s/DOMAIN_NAME/$DOMAIN_NAME/g" /etc/nginx/sites-available/default   

nginx -g "daemon off;"