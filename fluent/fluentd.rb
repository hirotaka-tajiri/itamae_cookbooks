package "td-agent" do
    action :install
end

[
    "fluent-plugin-hostname",
    "fluent-plugin-tail-ex",
].each{| plugin |
    execute plugin do
        action  :run
        command "/sbin/td-agent-gem install #{plugin}"
    end
}

[
    "source.d",
    "match.d",
].each{| dir |
    directory "/etc/td-agent/#{dir}" do
        action :create
        owner  "td-agent"
        group  "td-agent"
        mode   "777"
    end
}

[
    ["80.access.conf",             "/source.d/"],
    ["80.error.conf",              "/source.d/"],
    ["443.access.conf",            "/source.d/"],
    ["443.error.conf",             "/source.d/"],
    ["tcp.conf",                   "/source.d/"],
    ["socket.conf",                "/source.d/"],
    ["debug.conf",                 "/match.d/" ],
    ["hostname.conf",              "/match.d/" ],
    ["forward_centos7-admin.conf", "/match.d/" ],
    ["td-agent.conf",              "/"        ],
].each{| file_ary |
    template "/etc/td-agent#{file_ary[1]}#{file_ary[0]}" do
        action  :create
        owner   "td-agent"
        group   "td-agent"
        mode    "644"
        source  "files#{file_ary[1]}#{file_ary[0]}"
    end
}

service "td-agent" do
    action [:enable, :restart]
end
