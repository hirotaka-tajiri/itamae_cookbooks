CREATE DATABASE IF NOT EXISTS `gitlabhq_production` DEFAULT CHARACTER SET `utf8` COLLATE `utf8_unicode_ci`;
CREATE USER 'git'@'localhost' IDENTIFIED BY 'gitlab_gitlab';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, LOCK TABLES ON `gitlabhq_production`.* TO 'git'@'localhost';
DROP DATABASE test;
FLUSH PRIVILEGES;
