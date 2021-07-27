package aserto.tenant.profile.Profile.RemoveMember

default allowed = false

# global role
allowed {
  u = input.user
  not u.enabled == false

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.tenant.profile.Profile.RemoveMember"].allowed
}

# tenant context role
allowed {
  u = input.user
  not u.enabled == false

  t = input.resource["Aserto-Tenant-Id"]
  a = u.applications[t]

  some i
  data.roles.roles[a.roles[i]].perms["aserto.tenant.profile.Profile.RemoveMember"].allowed
}

# always allow a user to remove themselves
allowed {
  u = input.user
  not u.enabled == false

  a = input.resource["account_id"]

  a == u.id
}
