Meteor.methods
    seedUsers: ->
        if !Meteor.users.find({username: 'admin'}).count()
            Accounts.createUser
                username: 'admin'
                email: 'admin@fs.pl'
                password: 'admin'

        if !Meteor.users.find({username: 'moderator'}).count()
            Accounts.createUser
                username: 'moderator'
                email: 'moderator@fs.pl'
                password: 'moderator'

        if !Meteor.users.find({username: 'user'}).count()
            Accounts.createUser
                username: 'user'
                email: 'user@fs.pl'
                password: 'user'

        if !Meteor.users.find({username: 'admin'}).count()
            Accounts.createUser
                username: 'banned'
                email: 'banned@fs.pl'
                password: 'banned'
