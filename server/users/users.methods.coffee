Meteor.methods
    updateUsername: (username) ->
        if Meteor.user()
            Meteor.users.update({_id:Meteor.user()._id}, {$set:{"username": username}})

    updateEmail: (email) ->
        if Meteor.user()
            Meteor.users.update({_id:Meteor.user()._id}, {$set:{"emails": [{address: email}] }})

    updateProfile: (profile) ->
        if Meteor.user()
            Meteor.users.update({_id:Meteor.user()._id}, {$set:{"profile": profile}})
