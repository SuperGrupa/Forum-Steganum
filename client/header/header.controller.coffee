angular.module('forumSteganum')
.controller 'HeaderCtrl', ($meteor, $state) ->
    vm = this

    vm.logout = ->
        $meteor.logout().then ->
            $state.go 'home'
            return

    return vm
