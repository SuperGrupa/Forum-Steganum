rolesAServ = ($meteor, toastr) ->

  getAllRoles: () ->
    $meteor.collection(Roles, false).subscribe('rolesAdminPanel')

rolesAServ.$inject = ['$meteor', 'toastr']

angular.module 'admin'
.service 'rolesAServ', rolesAServ
