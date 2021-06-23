package aserto.common.info.Info.Config

default allowed = false

# global role
allowed {
  u = input.user

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.common.info.Info.Config"].allowed
}
