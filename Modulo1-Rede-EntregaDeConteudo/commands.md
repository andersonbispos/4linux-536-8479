## VPC

### Comandos pro lab de NACL

1 - Virar root:

```sh
sudo -i
```

2 - Instalar Apache

```sh
yum install httpd -y
```

3 - Alterar Index

```sh
echo "<html><h1>4linux - AWS SysOps Admin</h1></html>" > /var/www/html/index.html
```

4 - Habilitar o Apache

```sh
systemctl enable httpd
```

5 - Iniciar o Apache

```sh
systemctl start httpd
```

6 - Validar porta 80 está aberta e escutando

```sh
ss -tuln
```

## Route 53

### Startup script

```sh
#!/bin/bash
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`

sudo echo "<html><h1>Instance Data</h1><h3>Availability Zone: " > /var/www/html/index.html
sudo curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/placement/availability-zone >> /var/www/html/index.html
sudo echo "</h3><h3>Instance Id: " >> /var/www/html/index.html
sudo curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/instance-id >> /var/www/html/index.html
sudo echo "</h3><h3>Public IP: " >> /var/www/html/index.html
sudo curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/public-ipv4 >> /var/www/html/index.html
sudo echo "</h3><h3>Local IP: " >> /var/www/html/index.html
sudo curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/local-ipv4 >> /var/www/html/index.html
sudo echo "</h3></html> " >> /var/www/html/index.html
```

