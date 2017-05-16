package "redis" do
    action :install
    options "--enablerepo=epel,remi,remi-php71"
end

[
    ["redis.conf", "/etc"],
].each{| file_ary |
    template "#{file_ary[1]}/#{file_ary[0]}" do
        action  :create
        owner   "redis"
        group   "root"
        mode    "644"
        source  "files/#{file_ary[0]}"
    end
}

service "redis" do
    action [:enable, :restart]
end
