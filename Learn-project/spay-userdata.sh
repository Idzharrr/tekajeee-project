#!/bin/bash
yum update -y
yum install httpd -y
systemctl enable httpd
systemctl start httpd

# Download HTML dari GitHub
curl -o /var/www/html/index.html https://raw.githubusercontent.com/Idzharrr/tekajeee-project/main/Learn-project/spay-landingpage.html

# Permission
chown ec2-user:apache /var/www/html/index.html
chmod 664 /var/www/html/index.html
chown ec2-user:apache /var/www/html
chmod 775 /var/www/html
