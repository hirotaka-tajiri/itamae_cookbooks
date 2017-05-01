execute "ldap cache clear" do
    action  :run
    command "/sbin/sss_cache -E"
end
