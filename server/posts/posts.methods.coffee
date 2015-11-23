Counters = require 'Counters'

Meteor.methods
    addPost: (post) ->
        if !Meteor.userId()
            throw new (Meteor.Error)('not-authorized')

        Posts.insert
            id: incrementCounter(Counters, 'post_id').toString()
            text: post.text
            createdAt: new Date
            updatedAt: new Date
            topic_id: post.topic_id
            image_id: post.image_id
            userId: Meteor.userId()
    deletePost: (postId) ->
        # TODO autoryzacja czy jest adminem...
        post = Posts.findOne({ id: postId }, { fields: { image_id: 1 } })
        if post?
            Images.remove { _id: post.image_id }         # obrazki mają standardowe id od Mongo

        Posts.remove { id: postId }
    updatePost: (postId, text) ->
        # TODO autoryzacja czy jest twórcą posta...
        Posts.update { id: postId }, $set:
                                        text: text
                                        updatedAt: new Date
