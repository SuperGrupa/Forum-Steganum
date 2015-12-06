rolesACtrl = ($scope, $q, alertsServ, rolesAServ) ->
  rolesListener = {}
  emptyRole = {}

  rolesAServ.emptyRole().then (response) =>
    emptyRole = response
    emptyRole.updated = true
    emptyRole.selected = true


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
    createdRoles = 0
    promises = []
    this.roles.forEach (role, index) =>
      if role.selected
        if role._id
          promises[index] = rolesAServ.updateRole(role).then () =>
            updatedRoles++
        else
          promises[index] = rolesAServ.createRole(role).then () =>
            createdRoles++

    $q.all(promises).then () =>
      if createdRoles
        alertsServ.success('Created', 'You\'ve created ' + createdRoles + 'roles.')
      if updatedRoles
        alertsServ.success('Updated', 'You\'ve updated ' + updatedRoles + 'roles.')


  this.isRoleSelected = () =>
    !_.find this.roles, (role) => role.selected == true

  this.removeRole = (role) =>
    if (confirm("Are you sure to delete this role: " + role.name + "?"))
      if role._id == undefined
        this.roles  = _.without(this.roles, _.findWhere(this.roles, {name: role.name, _id: role._id}))
      else
        rolesAServ.removeRole(role)

  this.addNewRole = () =>
    this.roles.unshift(angular.copy(emptyRole))

  return this

rolesACtrl.$inject = ['$scope', '$q', 'alertsServ', 'rolesAServ']

angular.module('admin')
.controller 'rolesACtrl', rolesACtrl
