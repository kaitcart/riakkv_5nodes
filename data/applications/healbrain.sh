#! /usr/bin/env bash

case $HOSTNAME in
	nodekv[1-2].riak.local)
		iptables -D INPUT -s nodekv3.riak.local -j REJECT
		iptables -D OUTPUT -d nodekv3.riak.local -j REJECT
		iptables -D INPUT -s nodekv4.riak.local -j REJECT
		iptables -D OUTPUT -d nodekv4.riak.local -j REJECT
		iptables -D INPUT -s nodekv5.riak.local -j REJECT
		iptables -D OUTPUT -d nodekv5.riak.local -j REJECT
		;;
	nodekv[3-5].riak.local)
		iptables -D INPUT -s nodekv1.riak.local -j REJECT
		iptables -D OUTPUT -d nodekv1.riak.local -j REJECT
		iptables -D INPUT -s nodekv2.riak.local -j REJECT
		iptables -D OUTPUT -d nodekv2.riak.local -j REJECT
		;;
	*)
		;;
esac
