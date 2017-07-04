# disable ctl+alt+del
execute "ctl_alt_del" do
    action  :run
    command "ln -s /dev/null /etc/systemd/system/ctrl-alt-del.target"
end
