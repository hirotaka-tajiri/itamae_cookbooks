package "nginx_myrpm" do
    action :install
end

[
    "/var/www",
    "/var/www/ldap_auth",
].each {| dir |
    directory dir do
       action :create
       owner  "nginx"
       group  "nginx"
       mode   "755"
    end
}

[
    "server.crt",
    "server.key",
    "nginx.conf",
].each {| file |
    template "/etc/nginx/#{file}" do
        action :create
        owner  "nginx"
        group  "nginx"
        mode   "644"
        source "files/#{file}"
    end
}

[
    "index",
    "404",
    "50x",
].each{| com |
    execute "404" do
        command "echo \"#{com}\" > /var/www/ldap_auth/#{com}.html;chmod 666 /var/www/ldap_auth/#{com}.html"
        not_if  "test -e /var/www/ldap_auth/#{com}.html"
    end
}

service "nginx" do
    action [:enable, :start]
end
