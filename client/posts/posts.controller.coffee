angular.module('posts')
.controller 'PostCtrl', (postsServ) ->
  vm = this

  vm.post = postsServ

  return vm
