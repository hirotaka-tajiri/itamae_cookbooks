# File copy
[
    "syncprov-module.ldif",
    "syncprov.ldif",
    "mirror2.ldif",
].each {| tmp |
    template "/etc/openldap/ldif_files/#{tmp}" do
        action :create
        owner  "root"
        group  "root"
        mode   "644"
        source "files/ldap-server/adm2/#{tmp}"
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
execute "mirror2" do
    action  :run
    command "/bin/ldapmodify -Y EXTERNAL -H ldapi:// -f /etc/openldap/ldif_files/mirror2.ldif"
end