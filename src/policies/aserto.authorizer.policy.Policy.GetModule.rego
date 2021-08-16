package aserto.authorizer.policy.Policy.GetModule

default allowed = false

p = input.policy.path

# global role
allowed {
  u = input.user
  not u.enabled != true

  some i
  data.roles.roles[u.attributes.roles[i]].perms[p].allowed
}
