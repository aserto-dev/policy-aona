#!/usr/bin/env bash

echo "reflect over authorizer service"
grpcurl aona.beta.aserto.com:8443 list | xargs -n 1 -I {} grpcurl aona.beta.aserto.com:8443 list {} > perms.txt
echo "reflect over tenant service"
grpcurl tenant.beta.aserto.com:8443 list | xargs -n 1 -I {} grpcurl tenant.beta.aserto.com:8443 list {} >> perms.txt
echo "reflect over decision logs service"
grpcurl decision-logs.beta.aserto.com:8443 list | xargs -n 1 -I {} grpcurl decision-logs.beta.aserto.com:8443 list {} >> perms.txt
echo "sort"
sort -o perms.txt{,}

fileExits() {
	[ ! -f "$1" ] && echo "file missing $1"
}

echo "validating permissions"
while read perm; do
	# check if policy file exists
	fileExits "./src/policies/$perm.rego"

	# check if permission is in the perms table
	x=$(jq --arg P "$perm" '.perms | has($P) ' ./src/perms/data.json)
	if [ ${x} == "false" ]; then
		echo perm $perm missing from perms map
	fi

	f=false
	for role in $(jq -r '.roles | keys | .[]' src/roles/data.json); do
		x=$(jq --arg R "$role" --arg P "$perm" '.roles | .[$R] | .perms | has($P) ' ./src/roles/data.json)
		if [ $x == "true" ]; then
			f=true
		fi
	done

	if [ $f == "false" ]; then
		echo perm $perm appears in no roles
	fi

done <perms.txt
