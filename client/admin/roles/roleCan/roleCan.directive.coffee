roleCan = ->
  restrict: 'AE'
  scope:
    role: '='
    property: '@'
  bindToController: true
  templateUrl: 'client/admin/roles/roleCan/roleCan.directive.html'
  controllerAs: 'vm'
  controller: () ->
    this.roleModified = (role) =>
      role.updated = true
      role.selected = true

    return this


angular.module 'admin'
.directive 'roleCan', roleCan

