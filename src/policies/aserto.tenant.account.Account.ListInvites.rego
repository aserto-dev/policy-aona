package aserto.tenant.account.Account.ListInvites

default allowed = true

# global role
allowed {
  u = input.user

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.tenant.account.Account.ListInvites"].allowed
}

# # tenant role
# allowed {
#   u = input.user
#   t = input["Aserto-Tenant-Id"]

#   some i
#   data.roles.roles[u.applications[t].roles[i]].perms["aserto.tenant.account.Account.ListInvites"].allowed
# }
