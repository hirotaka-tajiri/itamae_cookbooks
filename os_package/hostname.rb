execute "hostname #{node[:name]}"

template "/etc/hostname" do
    source "files/hostname.erb"
end

template "/etc/hosts" do
    source "files/hosts.erb"
end

file "/etc/hosts" do
    action :edit
    block do | content |
        content.gsub!(/^([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} #{node[:name]})$/, '#\1')
    end
end
