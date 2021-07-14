package aserto.authorizer.directory.Directory.GetApplRoles

default allowed = false

# global role
allowed {
  u = input.user
  not u.enabled == false

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.authorizer.directory.Directory.GetApplRoles"].allowed
}

# tenant context role
allowed {
  u = input.user
  not u.enabled == false

  t = input.resource["name"]
  a = u.applications[t]

  some i
  data.roles.roles[a.roles[i]].perms["aserto.authorizer.directory.Directory.GetApplRoles"].allowed

  u.id != input.resource["id"]
}
