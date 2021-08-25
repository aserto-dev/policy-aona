package aserto.tenant.policy.v1.Policy.ListPolicyRefs

import input.user
import input.policy.path

default allowed = false

# global role
allowed {
  some i
  data.roles.roles[user.attributes.roles[i]].perms[path].allowed
}

# tenant context role
allowed {
  t = input.resource["Aserto-Tenant-Id"]
  a = user.applications[t]

  some i
  data.roles.roles[a.roles[i]].perms[path].allowed
}
