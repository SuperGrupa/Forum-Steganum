Meteor.publish 'usersBasicInfo', ->
    Meteor.users.find {}, fields:
        username: '1'
