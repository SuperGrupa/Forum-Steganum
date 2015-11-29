rolesACtrl = () ->
  vm = this

  vm.logout = ->
      loginServ.logout()

  return vm

rolesACtrl.$inject = []

angular.module('admin')
.controller 'rolesACtrl', rolesACtrl
