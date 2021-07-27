package aserto.authorizer.directory.Directory.GetIdentity

default allowed = false

# global role
allowed {
  u = input.user
  not u.enabled != true

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.authorizer.directory.Directory.GetIdentity"].allowed
}

# allow reading your own user
allowed {
  caller = input.user
  not caller.enabled != true
  
  targetID = dir.identity(input.resource["identity"])

  caller.id == targetID
}

# allow reading co-members of tenants
allowed {
  caller = input.user
  targetID = dir.identity(input.resource["identity"])
  targetUser = dir.user(targetID)

  some i, j
    caller.applications[i]
    targetUser.applications[j]
    i == j
}
