RolesFunctions = require('rolesFunctions')

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


RolesObject =
    admin:
        create: RolesFunctions.ptsu(true, true, true, true, true)
        read: RolesFunctions.ptsu(true, true, true, true, true)
        update: RolesFunctions.ptsu(true, true, true, true, true)
        remove: RolesFunctions.ptsu(true, true, true, true, true)
    moderator:
        create: RolesFunctions.ptsu(true, true, true, true)
        read: RolesFunctions.ptsu(true, true, true, true)
        update: RolesFunctions.ptsu(true, true, true, true)
        remove: RolesFunctions.ptsu(true, true, false, true)
    user:
        create: RolesFunctions.ptsu(true, true, true)
        read: RolesFunctions.ptsu(true, true, true, true)
        update: RolesFunctions.ptsu(true)
        remove: RolesFunctions.ptsu()
    banned:
        create: RolesFunctions.ptsu()
        read: RolesFunctions.ptsu()
        update: RolesFunctions.ptsu()
        remove: RolesFunctions.ptsu()
