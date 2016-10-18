[
    "bzip2", 
    "xz",
    "bind-utils",
    "lsof",
    "wget",
    "ntp",
    "postfix",
    "mailx",
].each {| pkg |
    package pkg do
        action :install
    end
}

template "/etc/ntp.conf" do
    action :create
    owner  "root"
    group  "root"
    source "files/ntp.conf"
end

service "ntpd" do
    action [:enable, :start]
end

[
    "tuned.service",
    "NetworkManager-dispatcher.service",
    "NetworkManager.service"
].each{| srv |
    service srv do
        action [:stop, :disable]
    end
}

template "/etc/logrotate.conf" do
    action :create
    owner  "root"
    group  "root"
    source "files/logrotate.conf.template"
end
