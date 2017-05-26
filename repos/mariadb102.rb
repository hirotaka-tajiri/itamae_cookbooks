template "/etc/yum.repos.d/mariadb.repo" do
    action :create
    owner  "root"
    group  "root"
    mode   "644"
    source "files/mariadb_10_2.repo"
end
