Meteor.publish null, ->
  Meteor.users.find({}, {fields: {profile: 1, username: 1, emails: 1, can: 1, createdAt: 1, role: 1}})

Meteor.publish 'usersBasicInfo', ->
    Meteor.users.find {}, fields:
        username: '1'

Meteor.publish 'usersAdminPanel', ->
    if Meteor.user().role == 'admin'
        Meteor.users.find({}, {fields: {profile: 1, username: 1, emails: 1, createdAt: 1, role: 1}})

