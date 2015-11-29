usersACtrl = (usersAServ) ->
  this.users = usersAServ.getAllUsers()

  this.someFunction = () =>
    console.log('asd')

  return this

usersACtrl.$inject = ['usersAServ']

angular.module('admin')
.controller 'usersACtrl', usersACtrl
