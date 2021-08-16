package aserto.authorizer.directory.Directory.SetApplProperties

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

  t = input.resource["name"]
  a = u.applications[t]

  some i
  data.roles.roles[a.roles[i]].perms[p].allowed

  u.id != input.resource["id"]
}
