## Prerequisites

vagrant, virtualbox and git.

## Create a cluster

This repo allows you to create a five node Riak KV 2.1.4 cluster with a client. It contains one Vagrantfile that specifies the configuration of the nodes including; using scripts to install riak kv, setting up /etc/hosts/, and creating a few bucket types. The client can also be used to install other development software such as Apache Spark and Grafana.


1. Add the base vagrant box for all 6 nodes: `vagrant box add bento/centos-7.2`
2. Clone the repo: `git clone https://github.com/kaitcarter/riakkv_5nodes.git`
3. Move into the directory with the Vagrantfile: `cd riakkv_5nodes`
4. Turn on all 6 nodes: `vagrant up`


## Log into cluster

Log into any of the nodes with `vagrant ssh nodekv1` 



