usersAServ = ($meteor, alertsServ) ->

  getAllUsers: () ->
    $meteor.collection(Meteor.users, false).subscribe('usersAdminPanel')

  updateUser: (user) ->
    $meteor.call('updateUser', user)

  removeUser: (user_id) ->
    $meteor.call('deleteUser', user_id).then ->
      alertsServ.success('Remove User', 'You\'ve removed an user.')
    , (error) ->
      alertsServ.error(error)

usersAServ.$inject = ['$meteor', 'alertsServ']

angular.module 'admin'
.service 'usersAServ', usersAServ
