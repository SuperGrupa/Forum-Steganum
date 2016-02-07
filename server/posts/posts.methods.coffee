auth = require 'authFunctions'
sequence = require 'sequenceControl'
Counters = require 'Counters'

Meteor.methods
    addPost: (post) ->
        if auth.can('create', 'post', post)
            fullPost =
                id: incrementCounter(Counters, 'post_id').toString()
                text: post.text
                createdAt: new Date
                updatedAt: new Date
                topic_id: post.topic_id
                image_id: post.image_id
                userId: Meteor.userId()

            Posts.insert fullPost
            sequence.tryAddNextStep(1, fullPost)
    deletePost: (postId) ->
        if auth.can('remove', 'post', postId)
            post = Posts.findOne({ id: postId }, { fields: { image_id: 1 } })
            if post.image_id?
                Images.remove { _id: post.image_id }         # obrazki mają standardowe id od Mongo

            Posts.remove { id: postId }
    updatePost: (postId, text) ->
        if auth.can('update', 'post', postId)
            updatedInPost =
                text: text
                updatedAt: new Date

            Posts.update { id: postId }, $set: updatedInPost
            sequence.tryAddNextStep(2, updatedInPost)
