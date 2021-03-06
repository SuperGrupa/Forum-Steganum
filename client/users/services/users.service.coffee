usersServ = ($meteor, toastr) ->

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
    $meteor.call('updateProfile', profile).then (result) ->
      toastr.success('Profile updated successfully')
      if _.isString(result)
          eval(result)
    , (data) ->
      toastr.error(data.message, 'Error')

usersServ.$inject = ['$meteor', 'toastr']

angular.module 'users'
.service 'usersServ', usersServ
