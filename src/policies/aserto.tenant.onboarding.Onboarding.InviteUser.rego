package aserto.tenant.onboarding.Onboarding.InviteUser

default allowed = false

p = input.policy.path

# global role
allowed {
  u = input.user
  not u.enabled != true

  some i
  data.roles.roles[u.attributes.roles[i]].perms[p].allowed
}
