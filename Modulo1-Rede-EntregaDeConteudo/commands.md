## Comandos pro lab de NACL

1 - Virar root:

```sh
sudo -i
```

2 - Instalar Apache

```sh
yum install httpd -y
```

3 - Habilitar o Apache

```sh
systemctl enable httpd
```

4 - Iniciar o Apache

```sh
systemctl start httpd
```

5 - Validar porta 80 está aberta e escutando

```sh
ss -tuln
```