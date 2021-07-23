package aserto.tenant.onboarding.Onboarding.InviteUser

default allowed = false
default visible = true
default enabled = false

# global role
allowed {
  u = input.user

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.tenant.onboarding.Onboarding.InviteUser"].allowed
}

enabled {
  allowed
}
