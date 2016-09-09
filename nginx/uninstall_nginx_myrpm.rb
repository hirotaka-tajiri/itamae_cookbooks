service "nginx" do
    action [:stop, :disable]
end

package "nginx_myrpm" do
    action :remove
end

[
    "systemctl daemon-reload",
    "yum clean all",
].each{| com |
    execute com do
        action  :run
        command com
    end
}
