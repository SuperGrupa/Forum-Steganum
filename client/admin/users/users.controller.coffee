usersACtrl = () ->
  vm = this

  vm.logout = ->
      loginServ.logout()

  return vm

usersACtrl.$inject = []

angular.module('admin')
.controller 'usersACtrl', usersACtrl
