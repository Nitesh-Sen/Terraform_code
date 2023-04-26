#!/bin/bash
apt update -y
apt install apache2 -y
systemctl start apache2
systemctl enable apache2 
echo "<h1>Hello From Terraform ;)</h1>" > /var/www/html/index.html