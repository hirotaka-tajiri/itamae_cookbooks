
# recipe
template "/etc/ssh/sshd_config" do
    action :create
    source "files/sshd_config.template"
end

service "sshd" do
    action :restart
end
