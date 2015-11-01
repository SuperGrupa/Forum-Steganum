Accounts.onCreateUser (options, user) ->
    if (options.username in ['admin', 'moderator', 'banned'])
        RolesFunctions.setRoleByName(user, options.username)
    else
        RolesFunctions.setDefaultRole(user)

