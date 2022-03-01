#!/usr/bin/env bash

echo "reflect over authorizer service"
grpcurl aona.eng.aserto.com:8443 list | xargs -I{} grpcurl aona.eng.aserto.com:8443 list {} > perms.txt
echo "reflect over tenant service"
grpcurl tenant.eng.aserto.com:8443 list | xargs -I{} grpcurl tenant.eng.aserto.com:8443 list {} >> perms.txt
echo "reflect over decision logs service"
grpcurl decision-logs.eng.aserto.com:8443 list | xargs -I{} grpcurl decision-logs.eng.aserto.com:8443 list {} >> perms.txt
echo "reflect over aserto registry service"
grpcurl registry.eng.aserto.com:8443 list | xargs -I{} grpcurl registry.eng.aserto.com:8443 list {} >> perms.txt
echo "reflect over registry tenant service"
grpcurl registry-tenant.eng.aserto.com:8443 list | xargs -I{} grpcurl registry-tenant.eng.aserto.com:8443 list {} >> perms.txt
echo "reflect over tasks service"
grpcurl tasks.eng.aserto.com:8443 list | xargs -I{} grpcurl tasks.eng.aserto.com:8443 list {} >> perms.txt

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

echo "Checking for endpoints that don't exist"

cat src/roles/data.json | jq -r .[][].perms | jq -r keys[] | xargs -I{} bash -c "grep '{}' perms.txt >/dev/null || echo '{} should not exist in src/roles/data.json'"

cat src/perms/data.json | jq -r .[] | jq -r keys[] | xargs -I{} bash -c "grep '{}' perms.txt >/dev/null || echo '{} should not exist in src/perms/data.json'"

find ./src/policies -name '*.rego' | xargs -I{} bash -c "basename {}" | sed s/\.rego//g | xargs -I{} bash -c "grep '{}' perms.txt >/dev/null || echo '{} should not exist in ./src/policies'"
