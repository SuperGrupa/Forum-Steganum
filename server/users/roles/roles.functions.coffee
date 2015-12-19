module.exports 'rolesFunctions',
    setRoleByName: (user, roleName) ->
        foundRole = Roles.find({ name: roleName }).fetch()
        setRole(user, foundRole)

    setDefaultRole: (user) ->
        foundRole = Roles.find({ default: true }).fetch()
        setRole(user, foundRole)

    ptsu: (self = false, p = false, t = false, s = false, u = false) ->
        return {
            post: p
            topic: t
            section: s
            user: u
            in:
                topic: []
                section: []
            self:
                post: self
                topic: self
                section: self
        }

setRole = (user, role) ->
    role = role[0]
    user.can = role.can
    user.role = role.name

    return user
