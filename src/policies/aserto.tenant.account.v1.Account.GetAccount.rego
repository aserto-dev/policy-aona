package aserto.tenant.account.v1.Account.GetAccount

import input.user

default allowed = false

# should always be able to read your own invites
allowed {
  not user.enabled != true

  user.id != ""
}
