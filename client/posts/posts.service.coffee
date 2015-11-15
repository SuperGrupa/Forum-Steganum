postsServ = ($meteor, toastr) ->
  add: (newPost) ->
      $meteor.call('addPost', newPost).then () ->
          toastr.success('You\'ve created a new post', 'New Post')
      , (data) ->
          toastr.error(data.message, 'Error')
  delete: (post) ->
      $meteor.call('deletePost', post.id).then () ->
          toastr.success('You\'ve removed a post', 'Remove Post')
      , (data) ->
          toastr.error(data.message, 'Error')
  update: (post) ->
      $meteor.call 'updatePost', post.id, post.text
  findOwner: (post) ->
      $meteor.object(Meteor.users, post.userId, false).subscribe('usersBasicInfo')

postsServ.$inject = ['$meteor', 'toastr']

angular.module 'posts'
.service 'postsServ', postsServ
