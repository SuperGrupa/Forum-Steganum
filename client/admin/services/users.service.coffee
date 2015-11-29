usersAServ = ($meteor, toastr) ->

  getAllUsers: () ->
    $meteor.collection(Meteor.users, false).subscribe('usersAdminPanel')

usersAServ.$inject = ['$meteor', 'toastr']

angular.module 'admin'
.service 'usersAServ', usersAServ
