package aserto.authorizer.directory.Directory.ListUsers

# global role
allowed {
  u = input.user

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.authorizer.directory.Directory.ListUsers"].allowed
}
