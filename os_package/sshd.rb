# recipe

[
    ["sshd_config", "0600"],
    ["ssh_config",  "0644"],
].each {| file_ary |
    template "/etc/ssh/#{file_ary[0]}" do
        action :create
        owner  "root"
        group  "root"
        source "files/#{file_ary[0]}.template"
        mode   "#{file_ary[1]}"
    end
}

service "sshd" do
    action :restart
end
