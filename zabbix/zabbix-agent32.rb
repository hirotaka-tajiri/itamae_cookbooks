package "zabbix-agent" do
    action :install
end

template "/etc/zabbix/zabbix_agentd.conf" do
    action :create
    owner  "root"
    group  "root"
    mode   "644"
    source "files/zabbix_agentd.conf"

end

service "zabbix-agent" do
    action [:enable, :restart]
end
