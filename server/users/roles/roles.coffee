@setRole = (user, roleName) ->
    user.can = Roles.find({ name: roleName }).fetch()
    user.role = roleName

    return user
