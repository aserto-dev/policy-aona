package aserto.authorizer.directory.Directory.ListResources

default allowed = false

# global role
allowed {
  u = input.user
  not u.enabled != true

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.authorizer.directory.Directory.ListResources"].allowed
}

# tenant context role
allowed {
  u = input.user
  not u.enabled != true

  t = input.resource["key"]
  a = u.applications[t]

  some i
  data.roles.roles[a.roles[i]].perms["aserto.authorizer.directory.Directory.ListResources"].allowed

  u.id != input.resource["id"]
}
