package aserto.authorizer.directory.Directory.GetUser

default allowed = false

# global role
allowed {
  u = input.user
  not u.enabled == false

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.authorizer.directory.Directory.GetUser"].allowed
}

# allow reading your own user
allowed {
  caller = input.user
  not caller.enabled == false

  targetID = input.resource["id"]

  caller.id == targetID
}

# allow reading co-members of tenants
allowed {
  caller = input.user
  not caller.enabled == false

  targetID = input.resource["id"]
  targetUser = dir.user(targetID)

  some i, j
    caller.applications[i]
    targetUser.applications[j]
    i == j
}
