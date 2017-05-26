execute "remi repos" do
    action  :run
    command "rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm"
    not_if  "test -e /etc/yum.repos.d/remi.repo"
end
