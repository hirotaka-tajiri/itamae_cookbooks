[
    "bzip2", 
    "xz",
    "rsync",
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

[
    ["/etc/ntp.conf",        "files/ntp.conf"               ],
    ["/etc/postfix/main.cf", "files/main.cf"                ],
    ["/etc/logrotate.conf",  "files/logrotate.conf.template"],
].each{| file_ary |
    template "#{file_ary[0]}" do
        action :create
        owner  "root"
        group  "root"
        source "#{file_ary[1]}"
    end
}

[
    "ntpd",
    "postfix",
].each{| srv |
    service srv do
        action [:enable, :start]
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
