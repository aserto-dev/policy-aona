package aserto.authorizer.directory.Directory.DeleteApplPermission

default allowed = false

# global role
allowed {
  u = input.user

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.authorizer.directory.Directory.DeleteApplPermission"].allowed
}

# tenant context role
allowed {
  u = input.user
  t = input.resource["name"]
  a = u.applications[t]

  some i
  data.roles.roles[a.roles[i]].perms["aserto.authorizer.directory.Directory.DeleteApplPermission"].allowed

  u.id != input.resource["id"]
}
