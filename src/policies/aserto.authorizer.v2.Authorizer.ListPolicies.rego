package aserto.authorizer.v2.Authorizer.ListPolicies

import input.user
import input.policy.path

default allowed = false

# global role
allowed {
  not user.enabled != true

  some i
  data.roles.roles[user.attributes.roles[i]].perms[path].allowed
}
