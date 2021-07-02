package aserto.authorizer.system.System.SetupRuntime

# global role
allowed {
  u = input.user

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.authorizer.system.System.SetupRuntime"].allowed
}
