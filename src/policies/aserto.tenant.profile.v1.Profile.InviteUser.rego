package aserto.tenant.profile.v1.Profile.InviteUser

import input.user
import input.policy.path

default allowed = false
default visible = true
default enabled = false

not_personal {
  t = input.resource["Aserto-Tenant-Id"]
  a = user.applications[t]

  not a.properties["personal"]
}

# global role
allowed {
  not user.enabled != true

  not_personal

  some i
  data.roles.roles[user.attributes.roles[i]].perms[path].allowed
}

# tenant context role
allowed {
  not user.enabled != true

  t = input.resource["Aserto-Tenant-Id"]
  a = user.applications[t]

  not_personal

  some i
  data.roles.roles[a.roles[i]].perms[path].allowed
}

enabled {
  t = input.resource["Aserto-Tenant-Id"]
  a = user.applications[t]

  not_personal

  some i
  a.roles[i] == "tenant_owner"
}
