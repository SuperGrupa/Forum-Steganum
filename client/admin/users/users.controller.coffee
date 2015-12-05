usersACtrl = ($q, alertsServ, usersAServ, rolesAServ) ->
  this.users = usersAServ.getAllUsers()
  this.roles = rolesAServ.getAllRoles()

  this.userModified = (user) =>
    user.updated = true
    user.selected = true

  this.saveUsers = () =>
    updatedUsers = 0
    promises = []
    this.users.forEach (user, index) =>
      if user.selected
        promises[index] = usersAServ.updateUser(user).then () =>
          updatedUsers++

    $q.all(promises).then () =>
      alertsServ.success('Updated', 'You\'ve updated ' + updatedUsers + 'users.')

  this.isUserSelected = () =>
    !_.find this.users, (user) => user.selected == true

  return this

usersACtrl.$inject = ['$q', 'alertsServ', 'usersAServ', 'rolesAServ']

angular.module('admin')
.controller 'usersACtrl', usersACtrl
