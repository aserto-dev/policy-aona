package aserto.authorizer.directory.Directory.GetUser

import input.user
import input.policy.path

default allowed = false

# global role
allowed {
  not user.enabled != true

  some i
  data.roles.roles[user.attributes.roles[i]].perms[path].allowed
}

# allow reading your own user
allowed {
  not user.enabled != true

  targetID = input.resource["id"]

  user.id == targetID
}

# allow reading co-members of tenants
allowed {
  not user.enabled != true

  targetID = input.resource["id"]
  targetUser = dir.user(targetID)

  some i, j
    user.applications[i]
    targetUser.applications[j]
    i == j
}
