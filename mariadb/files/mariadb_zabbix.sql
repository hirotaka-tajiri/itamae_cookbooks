CREATE DATABASE zabbix character set utf8;
GRANT ALL PRIVILEGES ON zabbix.* TO zabbix@localhost IDENTIFIED BY 'zabbix';
DROP DATABASE test;
FLUSH PRIVILEGES;
