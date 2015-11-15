Meteor.methods
    seedRoles: ->
        # usuń wszystkie role
        Roles.remove {}

        roles = [{
            name: 'admin'
            can: RolesObject['admin']
            default: false
        },
        {
            name: 'moderator'
            can: RolesObject['moderator']
            default: false
        },
        {
            name: 'user'
            can: RolesObject['user']
            default: true
        },
        {
            name: 'banned'
            can: RolesObject['banned']
            default: false
        }]

        Roles.insert role for role in roles


ptsu = (self = false, p = false, t = false, s = false, u = false) ->
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

RolesObject =
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
