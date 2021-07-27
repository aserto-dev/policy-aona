package aserto.tenant.profile.Profile.InviteUser

default allowed = false
default visible = true
default enabled = false

# global role
allowed {
  u = input.user
  not u.enabled != true

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.tenant.profile.Profile.InviteUser"].allowed
}

# tenant context role
allowed {
  u = input.user
  not u.enabled != true

  t = input.resource["Aserto-Tenant-Id"]
  a = u.applications[t]

  some i
  data.roles.roles[a.roles[i]].perms["aserto.tenant.profile.Profile.InviteUser"].allowed
}

enabled {
  allowed
}
