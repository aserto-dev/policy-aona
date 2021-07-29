package aserto.authorizer.directory.Directory.ListUserApplications

default allowed = false

# global role
allowed {
  u = input.user
  not u.enabled != true

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.authorizer.directory.Directory.ListUserApplications"].allowed
}

allowed {
  u = input.user
  not u.enabled != true

  u.id == input.resource["id"]
}
