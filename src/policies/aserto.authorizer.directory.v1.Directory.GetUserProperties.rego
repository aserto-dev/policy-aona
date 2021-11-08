package aserto.authorizer.directory.v1.Directory.GetUserProperties

import input.user

default allowed = false

# should always be able to read your own invites
allowed {
  not user.enabled != true

  user.id != ""
}
