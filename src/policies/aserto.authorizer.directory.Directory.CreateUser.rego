package aserto.authorizer.directory.Directory.CreateUser

# global role
allowed {
  u = input.user

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.authorizer.directory.Directory.CreateUser"].allowed
}
