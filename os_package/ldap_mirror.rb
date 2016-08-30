# File copy
[
    "syncprov-module.ldif",
    "syncprov.ldif",
    "#{node[:name]}.ldif",
].each {| tmp |
    template "/etc/openldap/ldif_files/#{tmp}" do
        action :create
        owner  "root"
        group  "root"
        mode   "644"
        source "files/ldap-server/mirror/#{tmp}"
    end 
}

# ldapadd
[
    "syncprov-module.ldif",
    "syncprov.ldif",
].each {| file |
    execute "#{file}" do
        action  :run
        command "/bin/ldapadd -Y EXTERNAL -H ldapi:// -f /etc/openldap/ldif_files/#{file}"
    end
}

# ldapmodify
execute "#{node[:name]}" do
    action  :run
    command "/bin/ldapmodify -Y EXTERNAL -H ldapi:// -f /etc/openldap/ldif_files/#{node[:name]}.ldif"
end
