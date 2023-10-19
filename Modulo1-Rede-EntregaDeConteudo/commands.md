## Comandos pro lab de NACL

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