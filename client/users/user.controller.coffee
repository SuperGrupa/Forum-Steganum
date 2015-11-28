UserCtrl = (loginServ) ->
  vm = this

  vm.auth = loginServ

  return vm

UserCtrl.$inject = ['loginServ']

angular.module('users')
.controller 'UserCtrl', UserCtrl
