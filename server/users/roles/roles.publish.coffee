Meteor.publish 'rolesAdminPanel', ->
    user = Meteor.users.findOne(this.userId)
    if user.role == 'admin'
        Roles.find({}, {fields: {name: 1, can: 1, default: 1}})
