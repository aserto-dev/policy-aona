package aserto.tenant.profile.Profile.RemoveMember

default allowed = false

p = input.policy.path

# global role
allowed {
  u = input.user
  not u.enabled != true

  some i
  data.roles.roles[u.attributes.roles[i]].perms[p].allowed
}

# tenant context role
allowed {
  u = input.user
  not u.enabled != true

  t = input.resource["Aserto-Tenant-Id"]
  a = u.applications[t]

  some i
  data.roles.roles[a.roles[i]].perms[p].allowed
}

# always allow a user to remove themselves
allowed {
  u = input.user
  not u.enabled != true

  a = input.resource["account_id"]

  a == u.id
}
