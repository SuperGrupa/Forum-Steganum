Posts = new Mongo.Collection("posts")

angular.module 'posts'
.service 'postsServ', ($meteor) ->
  all: $meteor.collection(Posts).subscribe('posts')

  add: (newPost) ->
    $meteor.call 'addPost', newPost

  delete: (post) ->
    $meteor.call 'deletePost', post._id

  update: (post) ->
    $meteor.call 'updatePost', post._id, post.text
