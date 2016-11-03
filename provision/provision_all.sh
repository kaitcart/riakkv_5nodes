#! /bin/sh

echo "Installing Packages..."
sed -i -e 's/keepcache=0/keepcache=1/g' -e 's/gpgcheck=1/gpgcheck=0/g' /etc/yum.conf
yum -q -y install epel-release
yum -q -y install deltarpm
yum -q -y install vim

echo "Setting up hosts file"
echo '
# Added by Vagrant Provisioning Script
10.10.10.16 clientkv.riak.local clientkv
10.10.10.17 nodekv1.riak.local nodekv1
10.10.10.18 nodekv2.riak.local nodekv2
10.10.10.19 nodekv3.riak.local nodekv3
10.10.10.20 nodekv4.riak.local nodekv4
10.10.10.21 nodekv5.riak.local nodekv5
' >> /etc/hosts

echo "Setting up SSH keys"
if [ ! -f /root/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -C "root@riak.local" -f /root/.ssh/id_rsa -N ""
	chmod 600 /root/.ssh/id_rsa*
    cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
fi

cp /root/.ssh/id_rsa* /home/vagrant/.ssh
chown vagrant /home/vagrant/.ssh/id_rsa*
chmod 600 /home/vagrant/.ssh/id_rsa
cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
chmod 644 /home/vagrant/.ssh/authorized_keys

echo "Disabling GSSAPIAuthentication"
sed -i -e 's/GSSAPIAuthentication yes/GSSAPIAuthentication no/g' /etc/ssh/ssh_config

echo "Installing Erlang Packages..."
if [ ! -f Downloads/erlang-solutions-1.0-1.noarch.rpm ]; then
	wget -q http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm \
		-O Downloads/erlang-solutions-1.0-1.noarch.rpm
fi

#yum -q -y install Downloads/erlang-solutions-1.0-1.noarch.rpm &> /dev/null
#yum -q -y install erlang

echo "export ERL_LIBS=/home/vagrant/sources/riak-erlang-client:/home/vagrant/sources/riak-erlang-client/deps/hamcrest:/home/vagrant/sources/riak-erlang-client/deps/meck:/home/vagrant/sources/riak-erlang-client/deps/protobuffs:/home/vagrant/sources/riak-erlang-client/deps/riak_pb" >> /home/vagrant/.bashrc
