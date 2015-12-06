rolesAServ = ($meteor, alertsServ) ->

  getAllRoles: () ->
    $meteor.collection(Roles, false).subscribe('rolesAdminPanel')

  emptyRole: () ->
    $meteor.call('emptyRole')

  createRole: (role) ->
    $meteor.call('createRole', role)

  updateRole: (role) ->
    $meteor.call('updateRole', role)

  removeRole: (role) ->
    $meteor.call('deleteRole', role).then ->
      alertsServ.success('Remove', 'You\'ve removed a role.')
    , (error) ->
      alertsServ.error(error)

rolesAServ.$inject = ['$meteor', 'alertsServ']

angular.module 'admin'
.service 'rolesAServ', rolesAServ
