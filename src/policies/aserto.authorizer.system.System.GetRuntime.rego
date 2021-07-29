package aserto.authorizer.system.System.GetRuntime

default allowed = false

# global role
allowed {
  u = input.user
  not u.enabled != true

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.authorizer.system.System.GetRuntime"].allowed
}
