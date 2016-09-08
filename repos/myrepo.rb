template "/etc/yum.repos.d/myrepo.repo" do
    action :create
    owner  "root"
    group  "root"
    mode   "644"
    source "files/myrepo.repo"
end
