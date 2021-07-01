package aserto.authorizer.directory.Directory.SetApplRoles

default allowed = false

# global role
allowed {
  u = input.user

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.authorizer.directory.Directory.SetApplRoles"].allowed
}

# tenant context role
allowed {
  u = input.user
  a = u.applications[t]

  some i
  data.roles.roles[a.roles[i]].perms["aserto.authorizer.directory.Directory.SetApplRoles"].allowed

  u.id != input.resource["Aserto-Tenant-Id"]
}