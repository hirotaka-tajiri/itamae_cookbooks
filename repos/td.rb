execute "Add td repo" do
    action  :run
    command "rpm --import https://packages.treasuredata.com/GPG-KEY-td-agent"
end

template "/etc/yum.repos.d/td.repo" do
    action :create
    owner  "root"
    group  "root"
    mode   "644"
    source "files/td.repo"
end
