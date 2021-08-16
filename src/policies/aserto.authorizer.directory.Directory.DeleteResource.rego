package aserto.authorizer.directory.Directory.DeleteResource

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

  t = input.resource["key"]
  a = u.applications[t]

  some i
  data.roles.roles[a.roles[i]].perms[p].allowed

  u.id != input.resource["id"]
}
