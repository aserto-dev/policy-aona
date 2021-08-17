package aserto.authorizer.directory.Directory.GetApplPermissions

import input.user
import input.policy.path

default allowed = false

# global role
allowed {
  not user.enabled != true

  some i
  data.roles.roles[user.attributes.roles[i]].perms[path].allowed
}

# tenant context role
allowed {
  not user.enabled != true

  t = input.resource["name"]
  a = user.applications[t]

  some i
  data.roles.roles[a.roles[i]].perms[path].allowed

  user.id != input.resource["id"]
}
