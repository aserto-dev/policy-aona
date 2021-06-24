package aserto.tenant.scc.SourceCodeCtl.GetProfile

default allowed = false

# global role
allowed {
  u = input.user

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.tenant.scc.SourceCodeCtl.GetProfile"].allowed
}

# tenant context role
allowed {
  u = input.user
  t = input.resource["Aserto-Tenant-Id"]
  a = u.applications[t]

  some i
  data.roles.roles[a.roles[i]].perms["aserto.tenant.scc.SourceCodeCtl.GetProfile"].allowed
}
