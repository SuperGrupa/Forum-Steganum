postsServ = ($meteor) ->
  add: (newPost) ->
      $meteor.call 'addPost', newPost
  delete: (post) ->
      $meteor.call 'deletePost', post.id
  update: (post) ->
      $meteor.call 'updatePost', post.id, post.text
  findOwner: (post) ->
      $meteor.object(Meteor.users, post.userId, false).subscribe('usersBasicInfo')

postsServ.$inject = ['$meteor']

angular.module 'posts'
.service 'postsServ', postsServ
