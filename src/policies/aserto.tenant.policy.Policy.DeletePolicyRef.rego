package aserto.tenant.policy.Policy.DeletePolicyRef

default allowed = false

# global role
allowed {
  u = input.user

  some i
  data.roles.roles[u.attributes.roles[i]].perms["aserto.tenant.policy.Policy.DeletePolicyRef"].allowed
}

# tenant context role
allowed {
  u = input.user
  t = input.resource["Aserto-Tenant-Id"]
  a = u.applications[t]

  some i
  data.roles.roles[a.roles[i]].perms["aserto.tenant.policy.Policy.DeletePolicyRef"].allowed
}
