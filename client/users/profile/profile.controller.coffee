angular.module('users')
.controller 'ProfileCtrl', ($scope, usersServ) ->
    vm = this

    vm.actions = usersServ

    return vm
