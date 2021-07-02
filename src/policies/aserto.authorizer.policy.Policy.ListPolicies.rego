package aserto.authorizer.policy.Policy.ListPolicies

default allowed = false

# global role
allowed {
  u = input.user

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.authorizer.policy.Policy.ListPolicies"].allowed
}
