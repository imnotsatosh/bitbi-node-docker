#!/bin/bash
set -e

testAlias+=(
	[bitbid:trusty]='bitbid'
)

imageTests+=(
	[bitbid]='
		rpcpassword
	'
)
