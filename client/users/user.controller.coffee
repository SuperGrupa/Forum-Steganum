UserCtrl = (authServ) ->
  vm = this

  vm.auth = authServ

  return vm

UserCtrl.$inject = ['authServ']

angular.module('users')
.controller 'UserCtrl', UserCtrl
