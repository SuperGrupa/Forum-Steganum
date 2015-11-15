auth = require('authFunctions')

Meteor.methods
    addPost: (post) ->
        if auth.can('create', 'post', post)
            Posts.insert
                id: incrementCounter(Counters, 'post_id').toString()
                text: post.text
                createdAt: new Date
                updatedAt: new Date
                topic_id: post.topic_id
                userId: Meteor.userId()
    deletePost: (postId) ->
        if auth.can('remove', 'post', postId)
            Posts.remove { id: postId }
    editPost: (postId, text) ->
        if auth.can('update', 'post', post)
            Posts.update { id: postId }, $set:
                                            text: text
                                            updatedAt: new Date
