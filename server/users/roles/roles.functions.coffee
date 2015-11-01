@RolesFunctions =
    setRoleByName: (user, roleName) ->
        foundRole = Roles.find({ name: roleName }).fetch()
        setRole(user, foundRole)

    setDefaultRole: (user) ->
        foundRole = Roles.find({ default: true }).fetch()
        setRole(user, foundRole)

setRole = (user, role) ->
    role = role[0]
    user.can = role.can
    user.role = role.name

    return user
