angular.module('posts')
.controller 'PostsListCtrl', (postsServ) ->
  vm = this

  vm.post = postsServ

  return vm
