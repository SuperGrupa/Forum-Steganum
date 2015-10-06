Posts = new Mongo.Collection("posts")

Meteor.methods
    getPostsByTopicId: (topic_id, page_number, posts_per_page) ->
        Posts.find(topic_id: topic_id,
            sort: createdAt: 1
            $slice: [(page_number - 1) * posts_per_page, posts_per_page]).fetch()
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

do ->
    if Posts.find().count() == 0
        user_id = this.userId || '1'

        posts = ({
            _id: num.toString()
            text: 'Some dummy text #' + num + ' in topic ' + ((num % 6) + 1).toString() 
            createdAt: new Date(2015, 10, 6, num % 24, 0, 0)
            updatedAt: new Date
            userId: user_id
            topic_id: ((num % 6) + 1).toString()
        } for num in [1..36])

        Posts.insert post for post in posts

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
