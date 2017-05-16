#!/bin/bash --login

# host
target_host="192.168.56.204"
run_user="hiro"
p_key="/home/hiro/.ssh/id_ed25519_hiro"

# itamae recipe
list_repo=("epel.rb" "remi.rb" "mariadb101.rb" "gitlab.rb")
list_recipe=("centos7_default.rb" "centos7_chrony.rb" "selinux.rb" "ldap_client.rb" "sshd.rb")
list_recipe1=("mariadb_gitlab.rb")
list_recipe2=("redis.rb")
list_recipe3=("gitlab.rb")


# RVM
rvm use ruby-2.3.3@itamae

# dry-run
if [ $# == 1 ]; then
    if [ $1 == "--dry-run" ]; then
        DRY_RUN="--dry-run"
    fi
fi

###
# yum repository
cd /root/itamae_cookbooks/repos

for str in ${list_repo[@]}
do
    itamae ssh -h ${target_host} -u ${run_user} -i ${p_key} ${str} ${DRY_RUN}
done 

###
# os
cd /root/itamae_cookbooks/os_package

# with json
    itamae ssh -h ${target_host} -u ${run_user} -i ${p_key} --node-json files/centos7-gitlab.json hostname.rb ${DRY_RUN}

# without json
for str in ${list_recipe[@]}
do
    itamae ssh -h ${target_host} -u ${run_user} -i ${p_key} ${str} ${DRY_RUN}
done 

###
# gitlab(mariadb)

cd /root/itamae_cookbooks/mariadb
for str in ${list_recipe1[@]}
do
    itamae ssh -h ${target_host} -u ${run_user} -i ${p_key} ${str} ${DRY_RUN}
done

###
# gitlab(redis)

cd /root/itamae_cookbooks/redis
for str in ${list_recipe2[@]}
do
    itamae ssh -h ${target_host} -u ${run_user} -i ${p_key} ${str} ${DRY_RUN}
done

###
# gitlab

cd /root/itamae_cookbooks/gitlab
for str in ${list_recipe3[@]}
do
    itamae ssh -h ${target_host} -u ${run_user} -i ${p_key} ${str} ${DRY_RUN}
done
