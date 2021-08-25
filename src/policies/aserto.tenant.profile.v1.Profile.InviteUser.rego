package aserto.tenant.profile.v1.Profile.InviteUser

import input.user
import input.policy.path

default allowed = false
default visible = true
default enabled = false

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

enabled {
  t = input.resource["Aserto-Tenant-Id"]
  a = user.applications[t]

  some i
  a.roles[i] == "tenant_owner"
}
