#!/bin/bash
yum update -y
yum install nginx -y
systemctl start nginx
systemctl enable nginx 
echo "<h1>Hello From Terraform ;)</h1>" > /usr/share/nginx/html/index.html
