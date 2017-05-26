CREATE DATABASE IF NOT EXISTS `gitbucket` DEFAULT CHARACTER SET `utf8` COLLATE `utf8_unicode_ci`;
CREATE USER 'git'@'localhost' IDENTIFIED BY 'gitbucket_gitbucket';
GRANT ALL PRIVILEGES ON `gitbucket`.* TO 'git'@'localhost';
GRANT ALL PRIVILEGES ON *.* TO 'git'@'localhost';
DROP DATABASE test;
FLUSH PRIVILEGES;
