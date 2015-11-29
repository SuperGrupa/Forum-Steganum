auth = require('authFunctions')

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

    checkPermissions: (what, name, object) ->
        auth.can(what, name, object)
