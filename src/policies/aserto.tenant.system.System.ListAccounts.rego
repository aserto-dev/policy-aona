package aserto.tenant.system.System.ListAccounts

default allowed = false

# global role
allowed {
  u = input.user
  not u.enabled != true

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.tenant.system.System.ListAccounts"].allowed
}
