RolesFunctions = require('rolesFunctions')

Meteor.methods
    emptyRole: (name) ->
        object =
            default: false
            name: if name then name else 'new role'
            can:
              create: RolesFunctions.ptsu()
              read: RolesFunctions.ptsu()
              update: RolesFunctions.ptsu()
              remove: RolesFunctions.ptsu()

    createRole: (role) ->
      if Meteor.user().role == 'admin'
        Roles.insert
          can: role.can
          default: role.default
          name: role.name

    updateRole: (role) ->
        if Meteor.user().role == 'admin'
            Roles.update({ _id: role._id }, {$set: {'can': role.can, 'name': role.name, 'default': role.default}})
            users = Meteor.users.find('role': role.name).fetch()
            users.forEach (user) =>
              user = RolesFunctions.setRoleByName(user, role.name)
              Meteor.users.update({ _id: user._id }, {$set: {'can': user.can, 'role': user.role}})

    deleteRole: (role) ->
        if Meteor.user().role == 'admin'
            users = Meteor.users.find('role': role.name).fetch()
            users.forEach (user) =>
                user = RolesFunctions.setDefaultRole(user)
                Meteor.users.update({ _id: user._id }, {$set: {'can': user.can, 'role': user.role}})
            Roles.remove { '_id': role._id }
