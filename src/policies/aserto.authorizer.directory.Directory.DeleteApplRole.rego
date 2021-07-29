package aserto.authorizer.directory.Directory.DeleteApplRole

default allowed = false

# global role
allowed {
  u = input.user
  not u.enabled != true

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.authorizer.directory.Directory.DeleteApplRole"].allowed
}

# tenant context role
allowed {
  u = input.user
  not u.enabled != true

  t = input.resource["name"]
  a = u.applications[t]

  some i
  data.roles.roles[a.roles[i]].perms["aserto.authorizer.directory.Directory.DeleteApplRole"].allowed

  u.id != input.resource["id"]
}
