
# recipe
template "/etc/selinux/config" do
  action :create
  source "files/selinux.config.template"
end
