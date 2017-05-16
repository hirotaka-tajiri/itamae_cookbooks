execute "add gitlab.repo" do
    action :run
    command "curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash"
end
