package aserto.authorizer.system.System.SetupRuntime

default allowed = false

# global role
allowed {
  u = input.user
  not u.enabled == false

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.authorizer.system.System.SetupRuntime"].allowed
}
