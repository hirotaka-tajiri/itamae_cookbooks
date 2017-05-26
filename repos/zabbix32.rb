execute "zabbix.repo" do
    action  :run
    command "rpm -ivh https://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm"
    not_if  "test -e /etc/yum.repos.d/zabbix.repo "
end
