#!/usr/bin/env bash

echo "Installing Dev Packages..."
#yum -q -y install git gcc

echo "Installing Erlang Client"

#if [ ! -d /home/vagrant/sources/riak-erlang-client ]; then
#	git clone -b 2.4.2 https://github.com/basho/riak-erlang-client.git /home/vagrant/sources/riak-erlang-client &> /dev/null
#fi

#cd ./sources/riak-erlang-client
#make &> /dev/null
#echo "alias erl_client='erl -pa $PWD/ebin $PWD/deps/*/ebin'" >> /home/vagrant/.bashrc
#cd

echo "Installing Python Client"
yum -q -y install libffi-devel openssl-devel python-devel python-pip
pip install riak &> /dev/null

echo "Installing Helper Apps"
yum -q -y install tmux
ln -s /vagrant/applications/tmux-cssh/tmux-cssh /usr/local/bin

echo "Creating ~/.tmux-cssh..."
echo "
others:-sc 10.10.10.18 -sc 10.10.10.19 -sc 10.10.10.20 -sc 10.10.10.21
node1:-sc 10.10.10.17
node2:-sc 10.10.10.18
node3:-sc 10.10.10.19
node4:-sc 10.10.10.20
node5:-sc 10.10.10.21
riak:-cs node1 -cs others
" > ~vagrant/.tmux-cssh

echo "Creating SSH settings"
echo "
Host 10.10.10.*
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null

Host nodekv*.riak.local
    StrictHostKeyChecking no
    UserKnownHostsFile=/dev/null
" >> ~vagrant/.ssh/config

echo "Client setup complete."
