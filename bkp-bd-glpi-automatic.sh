#!/bin/bash

#######################################
# Backup diario do BD MariaDB Do GLPI.
# Criado por Vanderson Pereira da Silva.
# email: vanderson.pereia.silva@gmail.com.br
# Distribuição CentOS 7 - MariaDB 10 PHP 7.0
# No passo 2 Retire as "" entre a senha e nome do Banco de Dados
#######################################

#1-VARIAVEIS
DATAHORA=`date +%Y-%m-%d-%H-%M`
MYSQLDUMP=/usr/bin/mysqldump
MYSQLDIR='cd /var/www/html/glpi/files/_dumps'


#2-Realizando o backup de todas as bases ou base específica
$MYSQLDUMP -uroot -p"password_BD"  "name_BD" > /var/www/html/glpi/files/_dumps/glpi_$DATAHORA.sql

#3-Acessando a pasta via váriavel
$MYSQLDIR

#4-Adicionando permissão no arquivo
chmod 777 glpi_$DATAHORA.sql

#5-compactando o sql
gzip -9 glpi_$DATAHORA.sql

#6-Montar compartilhamento windows FS
mount -t cifs -o username=user,pass=password //IP_do_compartilhamento_windows/XX/XXXXXX/ /mnt/bkpbd/

#7-Copiar bkp para compartilhamento FS
cp glpi_$DATAHORA.sql.gz /mnt/bkpbd

#8-Desmontar compartilhamento
umount /mnt/bkpbd
