Meteor.methods
    addPost: (text) ->
        if !Meteor.userId()
            throw new (Meteor.Error)('not-authorized')
        Posts.insert
            text: text
            createdAt: new Date
            updatedAt: new Date
            userId: Meteor.userId()
    deletePost: (postId) ->
        Posts.remove postId
    editPost: (postId, text) ->
        Posts.update postId, $set:
                                text: text
                                updatedAt: new Date
