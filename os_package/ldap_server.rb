# package install
[
    "openldap-devel",
    "openldap-servers",
].each {| pkg |
    package pkg do
        action :install
    end
}

# copy files
template "/etc/rsyslog.conf" do
    action :create
    owner  "root"
    group  "root"
    mode   "644"
    source "files/ldap-server/rsyslog.conf"
end

execute "sudo.schama" do
    action  :run
    command "find /usr/share/doc/ -type f -name schema.OpenLDAP -print0 | xargs -0 -I% cp %  /etc/openldap/schema/sudo.schema"
end

execute "openssh-lpk-openldap" do
    action  :run
    command "find /usr/share/doc/ -type f -name openssh-lpk-openldap.schema -print0 | xargs -0 -I% cp %  /etc/openldap/schema/openssh-lpk-openldap.schema"
end

execute "DB_CONFIG" do
    action  :run
    command "cp /usr/share/openldap-servers/DB_CONFIG.example /var/lib/ldap/DB_CONFIG"
end

[
    "/etc/openldap/certs",
    "/etc/openldap/ldif_files",
    "/etc/openldap/ldif_files/ldif_conv",
    "/etc/openldap/ldif_files/ldif_conv/cn=config",
    "/etc/openldap/ldif_files/ldif_conv/cn=config/cn=schema",
].each {| dir |
    directory dir do
        action :create
        owner  "root"
        group  "root"
    end
}

[
    "server.crt",
    "server.key",
].each {| tmp |
    template "/etc/openldap/certs/#{tmp}" do
        action :create
        owner  "root"
        group  "root"
        mode   "644"
        source "files/ldap-server/#{tmp}"
    end 
}

[
    "add_rootpw.ldif",
    "change-domain.ldif",
    "set_tls.ldif",
].each {| tmp |
    template "/etc/openldap/ldif_files/#{tmp}" do
        action :create
        owner  "root"
        group  "root"
        mode   "644"
        source "files/ldap-server/#{tmp}"
    end
}

template "/etc/openldap/ldif_files/ldif_conv/cn=config/cn=schema.ldif" do
    action  :create
    owner   "root"
    group   "root"
    mode    "644"
    source  "files/ldap-server/ldif_conv/cn=config/cn=schema.ldif"
end

[
    "cn={0}corba.ldif",
    "cn={1}core.ldif",
    "cn={2}cosine.ldif",
    "cn={3}duaconf.ldif",
    "cn={4}dyngroup.ldif",
    "cn={5}inetorgperson.ldif",
    "cn={6}java.ldif",
    "cn={7}misc.ldif",
    "cn={8}nis.ldif",
    "cn={9}openldap.ldif",
    "cn={10}ppolicy.ldif",
    "cn={11}collective.ldif",
    "cn={12}sudo.ldif",
    "cn={13}openssh-lpk-openldap.ldif",
].each {| tmp |
    template "/etc/openldap/ldif_files/ldif_conv/cn=config/cn=schema/#{tmp}" do
        action  :create
        owner   "root"
        group   "root"
        mode    "644"
        source  "files/ldap-server/ldif_conv/cn=config/cn=schema/#{tmp}"
    end
}

# setup ldap-server
service "slapd" do
    action :start
end

execute "rootpw" do
    action  :run
    command "/bin/ldapadd -Y EXTERNAL -H ldapi:// -f /etc/openldap/ldif_files/add_rootpw.ldif"
end

[
    "change-domain.ldif",
    "set_tls.ldif",
].each {| file |
    execute "#{file}" do
        action  :run
        command "/bin/ldapmodify -x -H ldapi:// -D cn=config -w 12345abcde -f /etc/openldap/ldif_files/#{file}"
    end
}

[
    "cn={0}corba.ldif",
#    "cn={1}core.ldif",
    "cn={2}cosine.ldif",
    "cn={3}duaconf.ldif",
    "cn={4}dyngroup.ldif",
    "cn={5}inetorgperson.ldif",
    "cn={6}java.ldif",
    "cn={7}misc.ldif",
    "cn={8}nis.ldif",
    "cn={9}openldap.ldif",
    "cn={10}ppolicy.ldif",
    "cn={11}collective.ldif",
    "cn={12}sudo.ldif",
    "cn={13}openssh-lpk-openldap.ldif",
].each {| file |
    execute "#{file}" do
        action  :run
        command "/bin/ldapadd -x -H ldapi:// -D cn=config -w 12345abcde -f /etc/openldap/ldif_files/ldif_conv/cn=config/cn=schema/#{file}"
    end
}

# restart ldap-server 
template "/etc/sysconfig/slapd" do
    action :create
    owner  "root"
    group  "root"
    mode   "644"
    source "files/ldap-server/slapd"
end

service "slapd" do
   action [:restart, :enable]
end
