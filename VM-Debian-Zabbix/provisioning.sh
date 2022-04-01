#!/usr/bin/env bash
################################################################################
# Name           : Zabbix | Debian installer
# Debian version : 11
# Zabbix version : 6.0-1
# Date           : 28/03/2022
# Version        : 1.0
# Author         : A.M.
################################################################################


sudo apt update
sudo apt -y install apache2 php php-mysql php-mysqlnd php-ldap php-bcmath php-mbstring php-gd php-pdo php-xml libapache2-mod-php mariadb-server mariadb-client
sudo apt update
wget --inet4-only https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-release_6.0-1+debian11_all.deb
sudo dpkg -i zabbix-release_6.0-1+debian11_all.deb
sudo apt update
sudo apt -y install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent 
# sudo sed 's@;date.timezone =@date.timezone=Europe/Warsaw@' -i /etc/php/7.4/apache2/php.ini;
sudo echo -e "[mysqld]\ndefault-storage-engine = innodb" | sudo tee /etc/mysql/conf.d/mysqld.conf;
sudo service mysql restart;
sudo mysql -e "create database zabbix character set utf8mb4 collate utf8mb4_bin"
sudo mysql -e "CREATE USER 'zabbix'@'localhost' IDENTIFIED BY 'zabbix';";
sudo mysql -e "grant all privileges on zabbix.* to zabbix@localhost;";
sudo zcat /usr/share/doc/zabbix-sql-scripts/mysql/server.sql.gz | mysql -u zabbix -pzabbix -D zabbix
sudo sed 's/# DBPassword=/DBPassword=zabbix/g' /etc/zabbix/zabbix_server.conf -i;
sudo apt -y install locales-all 
sudo systemctl restart zabbix-server zabbix-agent apache2 
sudo systemctl enable zabbix-server zabbix-agent apache2
