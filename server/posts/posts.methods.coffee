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
        # TODO autoryzacja czy jest adminem...
        Posts.remove { id: postId }
    editPost: (postId, text) ->
        # TODO autoryzacja czy jest twórcą posta...
        Posts.update { id: postId }, $set:
                                        text: text
                                        updatedAt: new Date
