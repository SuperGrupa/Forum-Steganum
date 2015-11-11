headerCtrl = (authServ) ->
  vm = this

  vm.logout = ->
      authServ.logout()

  return vm

headerCtrl.$inject = ['authServ']

angular.module('forumSteganum')
.controller 'HeaderCtrl', headerCtrl
