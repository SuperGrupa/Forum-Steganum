Accounts.onCreateUser (options, user) ->
    if (options.username in ['admin', 'moderator', 'banned'])
        setRoleByName(user, options.username)
    else
        setDefaultRole(user)

