package aserto.tenant.profile.v1.Profile.RespondToInvite

import input.user

default allowed = false

# should always be able to accept your invites
allowed {
  not user.enabled != true

  t = input.resource["Aserto-Tenant-Id"]
  a = user.applications[t]

  not a.properties["personal"]

  user.id != ""
}
