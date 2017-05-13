#!/bin/bash --login

# host
target_host="192.168.56.203"
run_user="hiro"
p_key="/home/hiro/.ssh/id_ed25519_hiro"

# itamae recipe
list_repo=("epel.rb")
list_recipe=("centos7_default.rb" "centos7_chrony.rb" "selinux.rb" "ldap_client.rb" "sshd.rb")
list_recipe1=("tomcat-gitbucket.rb")


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
    itamae ssh -h ${target_host} -u ${run_user} -i ${p_key} --node-json files/centos7-tomcat.json hostname.rb ${DRY_RUN}

# without json
for str in ${list_recipe[@]}
do
    itamae ssh -h ${target_host} -u ${run_user} -i ${p_key} ${str} ${DRY_RUN}
done 

###
# tomcat

cd /root/itamae_cookbooks/tomcat
for str in ${list_recipe1[@]}
do
    itamae ssh -h ${target_host} -u ${run_user} -i ${p_key} ${str} ${DRY_RUN}
done
