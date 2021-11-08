package aserto.tenant.onboarding.v1.Onboarding.ClaimTenant

import input.user

default allowed = false

# should always be able to read your own invites
allowed {
  not user.enabled != true

  user.id != ""
}
