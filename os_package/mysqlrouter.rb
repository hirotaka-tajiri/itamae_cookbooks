[
    "mariadb",
    "mysql-router"
].each{| pkg |
    package pkg do
        action :install
    end
}

template "/etc/mysqlrouter/mysqlrouter.ini" do
    action :create
    source "files/mysqlrouter.ini" 
    owner  "mysql"
    group  "mysql"
    mode   "755"
end

directory "/var/log/mysqlrouter" do
    action :create
    owner  "mysql"
    group  "mysql"
    mode   "777"
end

service "mysqlrouter.service" do
    action [:enable, :start]
end
