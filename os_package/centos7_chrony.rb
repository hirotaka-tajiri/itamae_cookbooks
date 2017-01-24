[
    "chrony",
].each {| pkg |
    package pkg do
        action :install
    end
}

[
    ["/etc/chrony.conf",        "files/chrony.conf.erb"],
].each{| file_ary |
    template "#{file_ary[0]}" do
        action :create
        owner  "root"
        group  "root"
        source "#{file_ary[1]}"
        mode   "0644"
    end
}

[
    "ntpd",
].each{| srv |
    service srv do
        action [:stop, :disable]
    end
}

[
    "chronyd",
].each{| srv |
    service srv do
        action [:enable, :start]
    end
}
