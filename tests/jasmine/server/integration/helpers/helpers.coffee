@Helpers =
    login: ->
        Meteor.userId = -> 1
    logout: ->
        Meteor.userId = -> 0
    clear: ->
        Posts.remove {}
        Topics.remove {}
        Sections.remove {}
    seed:
        post: (post) ->
            Helpers.login()
            Meteor.call 'addPost', post
            Helpers.logout()
        topic: (topic) ->
            Helpers.login()
            Meteor.call 'addTopic', topic
            Helpers.logout()
