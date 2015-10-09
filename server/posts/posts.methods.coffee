Meteor.methods
    getPostsByTopicId: (topic_id, page_number, posts_per_page) ->
        Posts.find(topic_id: topic_id,
            sort: createdAt: 1
            skip: (page_number - 1) * posts_per_page
            limit: posts_per_page
        ).fetch()
    getPost: (postId) ->
        Posts.findOne postId
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

Meteor.publishComposite 'posts', find: ->
    Posts.find {},
        sort: createdAt: 1
        children: [
            { find: (post) ->
                Meteor.users.find { _id: post.userId },
                    limit: 1
                    fields: username: 1
            }
        ]
