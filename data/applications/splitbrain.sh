#! /usr/bin/env bash

case $HOSTNAME in
	nodekv[1-2].riak.local)
		iptables -A INPUT -s nodekv3.riak.local -j REJECT
		iptables -A OUTPUT -d nodekv3.riak.local -j REJECT
		iptables -A INPUT -s nodekv4.riak.local -j REJECT
		iptables -A OUTPUT -d nodekv4.riak.local -j REJECT
		iptables -A INPUT -s nodekv5.riak.local -j REJECT
		iptables -A OUTPUT -d nodekv5.riak.local -j REJECT
		;;
	nodekv[3-5].riak.local)
		iptables -A INPUT -s nodekv1.riak.local -j REJECT
		iptables -A OUTPUT -d nodekv1.riak.local -j REJECT
		iptables -A INPUT -s nodekv2.riak.local -j REJECT
		iptables -A OUTPUT -d nodekv2.riak.local -j REJECT
		;;
	*)
		;;
esac
