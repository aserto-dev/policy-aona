package aserto.tenant.provider.v1.Provider.ListProviderKinds

import input.user

default allowed = false

# should always be able to read your own invites
allowed {
  not user.enabled != true

  user.id != ""
}
