package aserto.tenant.profile.v1.Profile.RespondToInvite

import input.user

default allowed = false

# should always be able to accept your invites
allowed {
  not user.enabled != true
  user.id != ""
}
