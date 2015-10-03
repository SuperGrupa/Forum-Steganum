angular.module('users')
.controller 'UserCtrl', (authServ) ->
  vm = this

  vm.auth = authServ

  return vm
