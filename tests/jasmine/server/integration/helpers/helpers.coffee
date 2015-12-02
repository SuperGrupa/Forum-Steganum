Helpers =
    login: (roleName) ->
        role = roleName

        if !Roles.find({}).count()
            Meteor.call 'seedRoles'
        if !Meteor.users.find({}).count()
            Meteor.call 'seedUsers'

        Meteor.userId = ->
            user = Meteor.users.findOne({ role: role })
            if user?
                user._id
            else ''
        Meteor.user = ->
            user = Meteor.users.findOne({ role: role })
            return user
    logout: ->
        Meteor.userId = -> ''
        Meteor.user = -> undefined
    clear: ->
        Images.remove {}
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

module.exports('Helpers', Helpers)
