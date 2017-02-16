[
    "apr",
    "apr-util",
    "httpd",
    "httpd-tools",
    "mailcap",
].each{| pkg |
    package pkg do
        action :install
    end
}

[
    "php",
    "php-devel",
    "php-cli",
    "php-common",
    "php-json",
    "php-mysql",
    "php-mysqlnd",
    "php-opcache",
    "php-mbstring",
].each{| pkg |
    package pkg do
        action :install
        options "--enablerepo=remi-php71"
    end
}

[
    ["/etc/httpd/conf/httpd.conf",             "files/php71/httpd.conf",           "root",   "0644"],
    ["/etc/httpd/conf.d/httpd-default.conf",   "files/php71/httpd-default.conf",   "root",   "0644"],
    ["/etc/httpd/conf.d/httpd-languages.conf", "files/php71/httpd-languages.conf", "root",   "0644"],
    ["/etc/httpd/conf.d/httpd-mpm.conf",       "files/php71/httpd-mpm.conf",       "root",   "0644"],
    ["/etc/php.ini",                           "files/php71/php.ini",              "root",   "0644"],
    ["/etc/php.d/10-opcace.ini",               "files/php71/10-opcache.ini",       "root",   "0644"],
    ["/var/www/html/index.php",                "files/php71/index.php",            "apache", "0644"],
    ["/etc/logrotate.d/php",                   "files/php71/php",                  "root",   "0644"],
].each{| file_ary |
    template "#{file_ary[0]}" do
        action :create
        owner  "#{file_ary[2]}"
        group  "#{file_ary[2]}"
        source "#{file_ary[1]}"
        mode   "#{file_ary[3]}"
    end
}

directory "/var/log/php" do
        action :create
        owner  "apache"
        group  "apache"
        mode   "0777"
end

service "httpd" do
    action [:enable, :start]
end
