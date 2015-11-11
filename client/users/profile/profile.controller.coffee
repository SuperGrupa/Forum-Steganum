ProfileCtrl = (usersServ) ->
    vm = this

    vm.actions = usersServ

    return vm


ProfileCtrl.$inject = ['usersServ']

angular.module('users')
.controller 'ProfileCtrl', ProfileCtrl
