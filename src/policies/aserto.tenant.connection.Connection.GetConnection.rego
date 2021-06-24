package aserto.tenant.connection.Connection.GetConnection

default allowed = false

# global role
allowed {
  u = input.user

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.tenant.connection.Connection.GetConnection"].allowed
}

# tenant context role
allowed {
  u = input.user
  t = input.resource["Aserto-Tenant-Id"]
  a = u.applications[t]

  some i
  data.roles.roles[a.roles[i]].perms["aserto.tenant.connection.Connection.GetConnection"].allowed
}
