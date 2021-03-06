package aserto.authorizer.directory.v1.Directory.ListUserApplications

import input.user
import input.policy.path

default allowed = false

# global role
allowed {
  not user.enabled != true

  some i
  data.roles.roles[user.attributes.roles[i]].perms[path].allowed
}

allowed {
  not user.enabled != true

  user.id == input.resource["id"]
}
