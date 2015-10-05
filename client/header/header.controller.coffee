angular.module('forumSteganum')
.controller 'HeaderCtrl', (authServ) ->
    vm = this

    vm.logout = ->
        authServ.logout()

    return vm
