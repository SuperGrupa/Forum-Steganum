@Helpers =
    login: (roleName) ->
        if !Roles.find({}).count()
            Meteor.call 'seedRoles'
        if Meteor.users.find({}).count()
            Meteor.call 'seedUsers'
        Meteor.userId = ->
            user = Meteor.users.findOne({ role: roleName })
            return user._id
        Meteor.user = ->
            user = Meteor.users.findOne({ role: roleName })
            if !user
                user =
                    _id: 'roleName'
                    username: 'Nitrooos'
                    emails: [
                        address: 'nitrooos@gmail.com'
                    ]
                    profile:
                        firstname: 'Nitr'
                        lastname: 'Ooos'
                Meteor.users.insert user

            return user
    logout: ->
        Meteor.userId = -> ''
        Meteor.user = -> undefined
    clear: ->
        Posts.remove {}
        Topics.remove {}
        Sections.remove {}
    seed:
        __inSession: (fun, params) ->
            if _.isFunction(fun) && _.isArray(params)
                Helpers.login('admin')
                fun.apply(undefined, params)
                Helpers.logout()

        post: (post) ->
            this.__inSession(Meteor.call, ['addPost', post])
        topic: (topic) ->
            this.__inSession(Meteor.call, ['addTopic', topic])
        section: (section) ->
            this.__inSession(Meteor.call, ['addSection', section])
