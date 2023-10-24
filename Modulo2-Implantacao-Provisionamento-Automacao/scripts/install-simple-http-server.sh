#!/bin/bash
sudo yum install -y httpd
sudo echo "<html><h1>Hello SysOps Admin</h1></html>" > /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd