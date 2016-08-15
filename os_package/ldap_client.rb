[
    "openldap-clients",
    "sssd",
    "nscd",
    "openssh-ldap",
].each {| pkg |
    package pkg do
        action :install
    end
}

template "/etc/openldap/ldap.conf" do
    action :create
    owner  "root"
    group  "root"
    source "files/ldap.conf.template"

end

execute "authconfig mkhomedir" do
    action  :run
    command "authconfig --enablemkhomedir --update"
end

execute "authconfig sssdauth" do
    action  :run
    command "authconfig --enablesssd --enablesssdauth --update"
end

template "/etc/sssd/sssd.conf" do
    action :create
    owner  "root"
    group  "root"
    source "files/sssd.conf.template"
end

template "/etc/pam.d/system-auth-ac" do
    action :create
    owner  "root"
    group  "root"
    source "files/system-auth-ac.template"
end

template "/etc/nsswitch.conf" do
    action :create
    owner  "root"
    group  "root"
    mode   "644"
    source "files/nsswitch.conf.template"
end

template "/etc/ssh/ldap.conf" do
    action :create
    owner  "root"
    group  "root"
    source "files/ssh_ldap.conf.template"
end

[
    "sssd",
    "sshd",
].each {| srv |
    service srv do
        action :restart
    end
}
