angular.module('users')
.controller 'NewUserCtrl', (authServ) ->
    vm = this

    vm.updateLogin = ->
      if authServ.email && !vm.regForm['userName'].$dirty
        authServ.userName = authServ.email.split("@").shift()

    return vm
