#!/bin/env bash

case $HOSTNAME in
	(nodekv2.riak.local)
	(nodekv3.riak.local)
	(nodekv4.riak.local)
	(nodekv5.riak.local) riak-admin cluster join riak@nodekv1.riak.local;;
	(*) ;;
esac
