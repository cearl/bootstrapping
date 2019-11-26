#!/bin/bash

hostName=$(hostname -f)
IP=$(ifconfig | grep inet | head -1 | awk '{print $2}')
PUPPET_HOSTS=$(grep puppet /etc/hosts)

if [ -z "$PUPPET_HOSTS" ];then
  echo "Adding puppet to hosts file"
  echo "$IP puppet" >> /etc/hosts
fi

# Install the puppet repo and master/agent
rpm -Uvh https://yum.puppet.com/puppet6-release-el-7.noarch.rpm
yum clean all; yum makecache
echo "installing puppet master"
yum -y install puppetserver sshpass ansible puppet-agent
chkconfig puppetserver on
service puppetserver start
