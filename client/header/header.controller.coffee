headerCtrl = (loginServ) ->
  vm = this

  vm.logout = ->
      loginServ.logout()

  return vm

headerCtrl.$inject = ['loginServ']

angular.module('forumSteganum')
.controller 'HeaderCtrl', headerCtrl
