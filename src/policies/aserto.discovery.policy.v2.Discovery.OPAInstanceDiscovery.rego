package aserto.discovery.policy.v2.Discovery.OPAInstanceDiscovery

# for now it is exactly the same as for v1 discovery - can be updated when needed

import input.user
import input.policy.path

default allowed = false

# global role
allowed {
  not user.enabled != true

  some i
  data.roles.roles[user.attributes.roles[i]].perms[path].allowed
}

# tenant context role
allowed {
  not user.enabled != true

  t = input.resource["Aserto-Tenant-Id"]
  a = user.applications[t]

  some i
  data.roles.roles[a.roles[i]].perms[path].allowed
}
