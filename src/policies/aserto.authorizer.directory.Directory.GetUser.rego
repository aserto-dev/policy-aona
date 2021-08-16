package aserto.authorizer.directory.Directory.GetUser

default allowed = false

p = input.policy.path

# global role
allowed {
  u = input.user
  not u.enabled != true

  some i
  data.roles.roles[u.attributes.roles[i]].perms[p].allowed
}

# allow reading your own user
allowed {
  caller = input.user
  not caller.enabled != true

  targetID = input.resource["id"]

  caller.id == targetID
}

# allow reading co-members of tenants
allowed {
  caller = input.user
  not caller.enabled != true

  targetID = input.resource["id"]
  targetUser = dir.user(targetID)

  some i, j
    caller.applications[i]
    targetUser.applications[j]
    i == j
}
