package aserto.registry_tenant.v1.Policy.DeletePolicyImage

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
