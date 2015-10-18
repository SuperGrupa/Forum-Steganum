angular.module 'users'
.service 'usersServ', ($meteor, $state, toastr) ->

  updateEmail: (email) ->
    $meteor.call('updateEmail', email).then ->
      toastr.success('Email updated successfully')
    , (data) ->
      toastr.error(data.message, 'Error')

  updateUsername: (username) ->
    $meteor.call('updateUsername', username).then ->
      toastr.success('Login updated successfully')
    , (data) ->
      toastr.error(data.message, 'Error')

  updateProfile: (profile) ->
    $meteor.call('updateProfile', profile).then ->
      toastr.success('Profile updated successfully')
    , (data) ->
      toastr.error(data.message, 'Error')



