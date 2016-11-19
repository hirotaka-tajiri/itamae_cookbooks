
# recipe

[
    "sshd_config", 
    "ssh_config"
].each {| f |
    template "/etc/ssh/#{f}" do
        action :create
        source "files/#{f}.template"
    end
}

service "sshd" do
    action :restart
end
