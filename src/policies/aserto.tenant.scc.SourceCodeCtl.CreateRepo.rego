package aserto.tenant.scc.SourceCodeCtl.CreateRepo

default allowed = false

# global role
allowed {
  u = input.user
  not u.enabled == false

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.tenant.scc.SourceCodeCtl.CreateRepo"].allowed
}

# tenant context role
allowed {
  u = input.user
  not u.enabled == false

  t = input.resource["Aserto-Tenant-Id"]
  a = u.applications[t]

  some i
  data.roles.roles[a.roles[i]].perms["aserto.tenant.scc.SourceCodeCtl.CreateRepo"].allowed
}
