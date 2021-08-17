package aserto.tenant.profile.Profile.RespondToInvite

import input.user

default allowed = false

# should always be able to accept your invites
allowed {
  not user.enabled != true

  user.id != ""
}
