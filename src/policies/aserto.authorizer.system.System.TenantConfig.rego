package aserto.authorizer.system.System.TenantConfig

default allowed = false

# global role
allowed {
  u = input.user

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.authorizer.system.System.TenantConfig"].allowed
}
