package aserto.authorizer.directory.Directory.DeleteUserPermission

default allowed = false

# global role
allowed {
  u = input.user

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.authorizer.directory.Directory.DeleteUserPermission"].allowed
}
