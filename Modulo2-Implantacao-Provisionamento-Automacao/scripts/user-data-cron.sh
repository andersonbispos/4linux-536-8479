#/bin/bash

sudo yum install -y cronie
sudo systemctl enable crond
sudo systemctl start crond