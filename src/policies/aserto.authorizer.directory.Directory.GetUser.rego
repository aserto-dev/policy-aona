package aserto.authorizer.directory.Directory.GetUser

default allowed = false

allowed {
  u = input.user

  u.id == input.resource["id"]
}
