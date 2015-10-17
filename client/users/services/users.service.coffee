angular.module 'users'
.service 'usersServ', ($meteor, $state) ->

  updateEmail: (email) ->
    $meteor.call 'updateEmail', email

  updateUsername: (username) ->
    $meteor.call('updateUsername', username)

  updateProfile: (profile) ->
    $meteor.call 'updateProfile', profile



