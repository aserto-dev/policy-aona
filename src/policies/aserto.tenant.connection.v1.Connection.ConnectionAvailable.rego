package aserto.tenant.connection.v1.Connection.ConnectionAvailable

import input.user

default allowed = false

allowed {
  not user.enabled != true

  user.id != ""
}
