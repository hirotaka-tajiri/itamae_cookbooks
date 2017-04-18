[
    "zabbix-server-mysql",
    "zabbix-web-mysql",
    "zabbix-web-japanese",
].each{| pkg |
    package pkg do
        action  :install
        options "--enablerepo=remi-php71"
    end
}

execute "import initial schema and data" do
    action  :run
    command "zcat /usr/share/doc/zabbix-server-mysql-3.2.*/create.sql.gz | /bin/mysql -uzabbix -pzabbix -Dzabbix"
end

[
    [ "/etc/zabbix/",            "zabbix_server.conf", "0640" ],
    [ "/usr/share/zabbix/conf/", "zabbix.conf.php",    "0755" ],
    [ "/etc/httpd/conf.d/",      "zabbix.conf",         "644" ],
].each {| file_ary |
    template "#{file_ary[0]}#{file_ary[1]}" do
        action :create
        owner  "root"
        group  "root"
        mode   "#{file_ary[2]}"
        source "files/#{file_ary[1]}"
    end
}

[ 
    "zabbix-server",
    "httpd",
].each {| srv |
    service srv do
        action [:enable, :restart]
    end
}
