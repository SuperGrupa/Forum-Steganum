Posts = new Mongo.Collection("posts")

Meteor.methods
  getPosts: (query) ->
    Tasks.find query, sort: createdAt: -1
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

Meteor.publishComposite 'posts',
  find: ->
    # Find top ten highest scoring posts
    Posts.find {},
      sort: createdAt: -1
  children: [
    { find: (post) ->
      # Find post author. Even though we only want to return
      # one record here, we use "find" instead of "findOne"
      # since this function should return a cursor.
      Meteor.users.find { _id: post.userId },
        limit: 1
        fields: username: 1
    }
  ]
