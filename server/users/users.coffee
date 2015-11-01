Accounts.onCreateUser (options, user) ->
    if (options.username not in ['admin', 'moderator', 'banned'])
        setRole(user, 'user')
    else
        setRole(user, options.username)

