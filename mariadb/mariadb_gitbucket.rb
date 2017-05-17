[
    "MariaDB-client",
    "MariaDB-common",
    "MariaDB-compat",
    "MariaDB-server",
    "MariaDB-shared",
    "MariaDB-devel",
].each {| pkg |
    package pkg do
        action :install
    end
}

[
    ["/etc/my.cnf.d/", "server.cnf"],
    ["/etc/my.cnf.d/", "mysql-clients.cnf"],
    ["/etc/my.cnf.d/", "client.cnf"],
    ["/tmp/",          "mariadb_gitbucket.sql"],
].each {| tmp |
    template "#{tmp[0]}#{tmp[1]}" do
        action :create
        owner  "root"
        group  "root"
        source "files/#{tmp[1]}"
        mode   "0644"
    end
}

execute "mariadb install db" do
    action  :run
    command "/bin/mysql_install_db --user=mysql --defaults-file=/etc/my.cnf"
    not_if  "test -e /var/lib/mysql/mysql"
end

service "mariadb" do
    action [:enable, :restart]
end

execute "CREATE DATABASE" do
    action  :run
    command "/bin/mysql -uroot < /tmp/mariadb_gitbucket.sql"
    not_if  "test -e /var/lib/mysql/gitbucket"
end

execute "DEL sql file" do
    action  :run
    command "rm -f /tmp/mariadb_gitbucket.sql"
    only_if "test -e /tmp/mariadb_gitbucket.sql"
end
