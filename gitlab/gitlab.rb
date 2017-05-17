execute "Install Development Tools" do
    action  :run
    command 'yum -y groupinstall "Development Tools"'
end

[
    "curl",
    "policycoreutils",
    "openssh-server",
    "openssh-clients",
    "postfix",
    "gitlab-ce",
    "openssl-devel",
    "keyutils-libs-devel",
    "krb5-devel",
    "libcom_err-devel",
    "libkadm5",
    "libselinux-devel",
    "libsepol-devel",
    "libverto-devel",
    "pcre-devel",
    "zlib-devel",
].each{| pkg |
    package pkg do
        action :install
    end
}

[
    ["/etc/gitlab/gitlab.rb", "files/gitlab.rb.template", "root", "0600"],
].each{| file_ary |
    template "#{file_ary[0]}" do
        action :create
        source "#{file_ary[1]}"
        owner  "#{file_ary[2]}"
        group  "#{file_ary[2]}"
        mode   "#{file_ary[3]}"
    end
}
