angular.module('users')
.controller 'LoginCtrl', ($meteor, $state) ->
    vm = this

    vm.credentials =
        email: '',
        password: ''

    vm.error = ''

    vm.login = ->
        $meteor.loginWithPassword(vm.credentials.email, vm.credentials.password).then (->
            if $state.previous.name then $state.go($state.previous) else $state.go('home')
        ), (err) ->
            vm.error = 'Login error - ' + err

    return vm
