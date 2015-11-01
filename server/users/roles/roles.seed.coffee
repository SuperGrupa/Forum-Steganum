Meteor.methods
    seedRoles: ->

        roles = [{
            name: 'admin'
            can: RolesObject['admin']
        },
        {
            name: 'moderator'
            can: RolesObject['moderator']
        },
        {
            name: 'user'
            can: RolesObject['user']
        },
        {
            name: 'banned'
            can: RolesObject['banned']
        }]

        Roles.insert role for role in roles


ptsu = (self = false, p = false, t = false, s = false, u = false) ->
    return {
        posts: p
        topics: t
        sections: s
        users: u
        in: []
        self:
            posts: self
            topics: self
            sections: self
    }

@RolesObject =
    admin:
        create: ptsu(true, true, true, true, true)
        read: ptsu(true, true, true, true, true)
        update: ptsu(true, true, true, true, true)
        remove: ptsu(true, true, true, true, true)
    moderator:
        create: ptsu(true, true, true, true)
        read: ptsu(true, true, true, true)
        update: ptsu(true, true, true, true)
        remove: ptsu(true, true, false, true)
    user:
        create: ptsu(true, true, true)
        read: ptsu(true, true, true)
        update: ptsu(true)
        remove: ptsu()
    banned:
        create: ptsu()
        read: ptsu()
        update: ptsu()
        remove: ptsu()
