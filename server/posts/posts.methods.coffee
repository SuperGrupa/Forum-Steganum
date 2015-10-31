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
            userId: Meteor.userId()
    deletePost: (postId) ->
        Posts.remove { id: postId }
    editPost: (postId, text) ->
        Posts.update postId, $set:
                                text: text
                                updatedAt: new Date
