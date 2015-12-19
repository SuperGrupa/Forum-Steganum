auth = require('authFunctions')
rolesFunctions = require('rolesFunctions')

Meteor.methods
    updateUsername: (username) ->
        if Meteor.user()
            Meteor.users.update({_id:Meteor.user()._id}, {$set:{"username": username}})
        else
            throw new Meteor.Error( 500, 'You are not logged in')

    updateEmail: (email) ->
        if Meteor.user()
            Meteor.users.update({_id:Meteor.user()._id}, {$set:{"emails": [{address: email}] }})
        else
            throw new Meteor.Error( 500, 'You are not logged in')

    updateProfile: (profile) ->
        if Meteor.user()
            Meteor.users.update({_id:Meteor.user()._id}, {$set:{"profile": profile}})
        else
            throw new Meteor.Error( 500, 'You are not logged in')

    updateUser: (user) ->
        if Meteor.user() && Meteor.user().role == 'admin'
            user = rolesFunctions.setRoleByName(user, user.role)
            Meteor.users.update({ _id: user._id }, {$set: {'can': user.can, 'role': user.role}})
        else
            throw new (Meteor.Error)('notAuthorized')

    deleteUser: (user_id) ->
        if Meteor.user() && Meteor.user().role == 'admin'
            Meteor.users.remove { '_id': user_id }
        else
            throw new (Meteor.Error)('notAuthorized')

