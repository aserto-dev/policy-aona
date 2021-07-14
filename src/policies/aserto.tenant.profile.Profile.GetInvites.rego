package aserto.tenant.profile.Profile.GetInvites

default allowed = false

# global role
allowed {
  u = input.user

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.tenant.profile.Profile.GetInvites"].allowed
}

# should always be able to read your invites
allowed {
  u = input.user

  u.id != ""
}
