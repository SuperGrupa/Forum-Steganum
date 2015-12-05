usersAServ = ($meteor, toastr) ->

  getAllUsers: () ->
    $meteor.collection(Meteor.users, false).subscribe('usersAdminPanel')

  updateUser: (user) ->
    $meteor.call('updateUser', user)

usersAServ.$inject = ['$meteor', 'toastr']

angular.module 'admin'
.service 'usersAServ', usersAServ
