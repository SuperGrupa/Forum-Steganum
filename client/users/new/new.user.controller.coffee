NewUserCtrl = (loginServ) ->
    vm = this

    vm.updateLogin = ->
      if loginServ.email && !vm.regForm['userName'].$dirty
        loginServ.userName = loginServ.email.split("@").shift()

    return vm


NewUserCtrl.$inject = ['loginServ']

angular.module('users')
.controller 'NewUserCtrl', NewUserCtrl
