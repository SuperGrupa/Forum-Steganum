@Helpers =
    login: ->
        Meteor.userId = -> 1
    logout: ->
        Meteor.userId = -> 0
    seed: (post) ->
        Meteor.call 'addPost', post
