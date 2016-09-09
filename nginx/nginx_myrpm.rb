package "nginx_myrpm" do
    action :install
end

[
    "/var/www",
    "/var/www/ldap_auth",
    "/etc/nginx/html/auth",
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
    "nginx.digest",
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
        action  :run
        command "echo \"#{com}\" > /var/www/ldap_auth/#{com}.html;chmod 666 /var/www/ldap_auth/#{com}.html"
        not_if  "test -e /var/www/ldap_auth/#{com}.html"
    end
}

execute "digest index" do
    action  :run
    command "echo 'digest auth OK' > /etc/nginx/html/auth/index.html"
    not_if  "test -e /etc/nginx/html/auth/index.html"
end

service "nginx" do
    action [:enable, :start]
end
