[
  "bzip2", 
  "xz",
  "bind-utils",
  "lsof",
  "wget",
].each {| pkg |
    package pkg do
        action :install
    end
}


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

