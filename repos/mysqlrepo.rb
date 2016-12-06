execute "add mysql.repo" do
    action :run
    command "rpm -ivh http://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm"
end
