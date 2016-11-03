#!/usr/bin/env bash

echo "Installing Riak"
if [ ! -f Downloads/config_file.repo ]; then
    curl -LO http://s3.amazonaws.com/downloads.basho.com/riak/2.1/2.1.4/rhel/7/riak-2.1.4-1.el7.centos.x86_64.rpm
fi
cp Downloads/config_file.repo /etc/yum.repos.d/basho_riak.repo

yum -y install riak-2.1.4-1.el7.centos.x86_64

echo "Configuring Riak on node $(hostname)"
echo "nodename = riak@$(hostname)" >> /etc/riak/riak.conf
echo "listener.http.internal = 0.0.0.0:8098" >> /etc/riak/riak.conf
echo "listener.protobuf.internal = 0.0.0.0:8087" >> /etc/riak/riak.conf

echo "Increasing File Limits"
echo '
# Added by Vagrant Provisioning Script
# ulimit settings for Riak
riak soft nofile 65536
riak hard nofile 65536

'  >> /etc/security/limits.d/90-riak.conf

chkconfig riak on
service riak start
riak-admin wait-for-service riak_kv &> /dev/null

echo "Installing Helper Scripts"
ln -s /vagrant/applications/healbrain.sh /usr/local/bin
ln -s /vagrant/applications/splitbrain.sh /usr/local/bin
