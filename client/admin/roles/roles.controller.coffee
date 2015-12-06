rolesACtrl = ($scope, $q, alertsServ, rolesAServ) ->
  rolesListener = {}

  this.roles = rolesAServ.getAllRoles()

  rolesListener = $scope.$watch(( =>
    this.roles
  ), () =>
    this.defaultRole = _.find this.roles, (role) => role.default == true
    if !!this.defaultRole
      rolesListener()
  , true)

  this.roleModified = (role) =>
    role.updated = true
    role.selected = true

  this.saveRoles = () =>
    updatedRoles = 0
    promises = []
    this.roles.forEach (role, index) =>
      if role.selected
        promises[index] = rolesAServ.updateRole(role).then () =>
          updatedRoles++

    $q.all(promises).then () =>
      alertsServ.success('Updated', 'You\'ve updated ' + updatedRoles + 'roles.')

  this.isRoleSelected = () =>
    !_.find this.roles, (role) => role.selected == true

  this.removeRole = (role) =>
    rolesAServ.removeRole(role._id)

  return this

rolesACtrl.$inject = ['$scope', '$q', 'alertsServ', 'rolesAServ']

angular.module('admin')
.controller 'rolesACtrl', rolesACtrl
