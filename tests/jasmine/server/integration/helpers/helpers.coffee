Helpers =
    login: ->
        Meteor.userId = -> '1'
        Meteor.user = ->
            user = Meteor.users.findOne({ _id: '1' })
            if !user
                user =
                    _id: '1'
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
                Helpers.login()
                fun.apply(undefined, params)
                Helpers.logout()

        post: (post) ->
            this.__inSession(Meteor.call, ['addPost', post])
        topic: (topic) ->
            this.__inSession(Meteor.call, ['addTopic', topic])
        section: (section) ->
            this.__inSession(Meteor.call, ['addSection', section])

module.exports('Helpers', Helpers)
