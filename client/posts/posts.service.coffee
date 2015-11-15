postsServ = ($meteor, alertsServ) ->
    add: (newPost) ->
      $meteor.call('addPost', newPost).then () ->
          alertsServ.success('New Post', 'You\'ve created a new post')
      , (error) ->
          alertsServ.error(error)
    delete: (post) ->
      $meteor.call('deletePost', post.id).then () ->
          alertsServ.success('Remove Post', 'You\'ve removed a post')
      , (error) ->
          alertsServ.error(error)
    update: (post) ->
      $meteor.call('updatePost', post.id, post.text).then () ->
          alertsServ.success('Update Post', 'You\'ve updated a post')
      , (error) ->
          alertsServ.error(error)
    findOwner: (post) ->
      $meteor.object(Meteor.users, post.userId, false).subscribe('usersBasicInfo')

postsServ.$inject = ['$meteor', 'alertsServ']

angular.module 'posts'
.service 'postsServ', postsServ
