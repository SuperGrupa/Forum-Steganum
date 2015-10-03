angular.module('forumSteganum')
.controller 'HeaderCtrl', (authServ, $rootScope) ->
    vm = this

    vm.logout = ->
        authServ.logout()

    return vm
